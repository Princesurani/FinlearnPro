import pytest
from simulation.price_engine import GBMPriceModel, JumpDiffusionModel, GBMWithGARCH

def test_gbm_price_model():
    model = GBMPriceModel(initial_price=100.0, drift=0.08, volatility=0.20)
    prices = [model.generate_next_price() for _ in range(100)]
    
    assert len(prices) == 100
    assert all(p > 0 for p in prices), "Prices should not go below 0"

def test_jump_diffusion_model():
    model = JumpDiffusionModel(initial_price=150.0, drift=0.10, volatility=0.25)
    prices = [model.generate_next_price() for _ in range(100)]
    
    assert len(prices) == 100
    assert all(p > 0 for p in prices), "Prices should stay positive"

def test_gbm_with_garch():
    model = GBMWithGARCH(initial_price=50.0, drift=0.12, base_volatility=0.30)
    results = [model.generate_next_price() for _ in range(100)]
    
    prices = [r[0] for r in results]
    volatilities = [r[1] for r in results]
    
    assert len(prices) == 100
    assert all(p > 0 for p in prices)
    assert all(v > 0 for v in volatilities), "Volatility must remain positive"
