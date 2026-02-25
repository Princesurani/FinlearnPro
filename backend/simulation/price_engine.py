import numpy as np
from typing import Tuple, List

# Implementation based on ADR-005 Models

class GBMPriceModel:
    """Base price model using Geometric Brownian Motion (GBM)"""
    def __init__(self, initial_price: float, drift: float, volatility: float, dt: float = 1 / (252 * 10000)):
        self.price = initial_price
        self.drift = drift
        self.volatility = volatility
        self.dt = dt  # Balanced to allow visible but stable cent-level ticks

    def generate_next_price(self) -> float:
        dW = np.random.normal(0, np.sqrt(self.dt))
        dS = self.price * (self.drift * self.dt + self.volatility * dW)
        self.price += dS
        return max(self.price, 0.01)

class JumpDiffusionModel:
    """Merton's Jump Diffusion Model for sudden price movements"""
    def __init__(
        self, 
        initial_price: float,
        drift: float,
        volatility: float,
        jump_intensity: float = 2.0,
        jump_mean: float = 0.0,
        jump_std: float = 0.10
    ):
        self.price = initial_price
        self.drift = drift
        self.volatility = volatility
        self.jump_intensity = jump_intensity
        self.jump_mean = jump_mean
        self.jump_std = jump_std
        self.dt = 15 / (252 * 390 * 60)

    def generate_next_price(self) -> float:
        k = np.exp(self.jump_mean + 0.5 * self.jump_std**2) - 1
        adjusted_drift = self.drift - self.jump_intensity * k
        
        dW = np.random.normal(0, np.sqrt(self.dt))
        gbm_component = self.price * (adjusted_drift * self.dt + self.volatility * dW)
        
        num_jumps = np.random.poisson(self.jump_intensity * self.dt)
        jump_component = 0.0
        
        if num_jumps > 0:
            jump_sizes = np.random.normal(self.jump_mean, self.jump_std, num_jumps)
            for jump in jump_sizes:
                jump_component += self.price * (np.exp(jump) - 1)
        
        self.price = self.price + gbm_component + jump_component
        return max(self.price, 0.01)

class GARCHVolatilityModel:
    """GARCH(1,1) Model for time-varying volatility clustering"""
    def __init__(
        self,
        omega: float = 0.000001,
        alpha: float = 0.1,
        beta: float = 0.85
    ):
        self.omega = omega
        self.alpha = alpha
        self.beta = beta
        self.variance = omega / (1 - alpha - beta)
        self.last_shock = 0.0

    def update_volatility(self, return_val: float) -> float:
        shock = return_val - np.mean(return_val) if hasattr(return_val, '__len__') else return_val
        self.variance = self.omega + self.alpha * shock**2 + self.beta * self.variance
        self.last_shock = shock
        return np.sqrt(self.variance)

class GBMWithGARCH:
    """Combined GBM with GARCH volatility for realistic simulation."""
    def __init__(self, initial_price: float, drift: float, base_volatility: float):
        self.price = initial_price
        self.drift = drift
        self.garch = GARCHVolatilityModel()
        self.garch.variance = base_volatility**2
        self.dt = 15 / (252 * 390 * 60)

    def generate_next_price(self) -> Tuple[float, float]:
        volatility = np.sqrt(self.garch.variance)
        dW = np.random.normal(0, np.sqrt(self.dt))
        return_val = self.drift * self.dt + volatility * dW
        
        self.price *= (1 + return_val)
        self.garch.update_volatility(return_val)
        
        return max(self.price, 0.01), volatility
