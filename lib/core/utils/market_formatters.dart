import '../domain/market_regime.dart';

abstract class MarketFormatter {
  String formatCurrency(double amount, {int? decimals});
  String formatLargeNumber(double amount);
  String formatPercentage(double pct, {int decimals = 2, bool showSign = true});
  String formatVolume(double volume);
  String formatPrice(double price, {int? decimals});
  String formatChange(double change, double changePercent);
}

class MarketFormatterFactory {
  static MarketFormatter forMarket(MarketRegime market) {
    switch (market) {
      case MarketRegime.usa:
        return WesternMarketFormatter(currencySymbol: '\$');
      case MarketRegime.india:
        return IndianMarketFormatter();
      case MarketRegime.uk:
        return WesternMarketFormatter(currencySymbol: '£');
      case MarketRegime.crypto:
        return CryptoMarketFormatter();
    }
  }
}


class IndianMarketFormatter implements MarketFormatter {
  @override
  String formatCurrency(double amount, {int? decimals}) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (absAmount >= 10000000) {
      final crores = absAmount / 10000000;
      return '$sign₹${_formatNumber(crores, decimals ?? 2)}Cr';
    } else if (absAmount >= 100000) {
      final lakhs = absAmount / 100000;
      return '$sign₹${_formatNumber(lakhs, decimals ?? 2)}L';
    } else if (absAmount >= 1000) {
      final thousands = absAmount / 1000;
      return '$sign₹${_formatNumber(thousands, decimals ?? 1)}K';
    } else {
      return '$sign₹${_formatNumber(absAmount, decimals ?? 0)}';
    }
  }

  @override
  String formatLargeNumber(double amount) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (absAmount >= 10000000) {
      return '$sign${_formatNumber(absAmount / 10000000, 2)}Cr';
    } else if (absAmount >= 100000) {
      return '$sign${_formatNumber(absAmount / 100000, 2)}L';
    } else if (absAmount >= 1000) {
      return '$sign${_formatNumber(absAmount / 1000, 1)}K';
    } else {
      return '$sign${_formatNumber(absAmount, 0)}';
    }
  }

  @override
  String formatPrice(double price, {int? decimals}) {
    return '₹${_formatNumber(price, decimals ?? 2)}';
  }

  @override
  String formatPercentage(double pct, {int decimals = 2, bool showSign = true}) {
    final sign = showSign && pct > 0 ? '+' : '';
    return '$sign${_formatNumber(pct, decimals)}%';
  }

  @override
  String formatVolume(double volume) {
    return formatLargeNumber(volume);
  }

  @override
  String formatChange(double change, double changePercent) {
    final sign = change >= 0 ? '+' : '';
    return '$sign${formatPrice(change.abs())} ($sign${_formatNumber(changePercent, 2)}%)';
  }

  String _formatNumber(double value, int decimals) {
    final str = value.toStringAsFixed(decimals);
    final parts = str.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? parts[1] : '';

    final buffer = StringBuffer();
    var count = 0;
    for (var i = intPart.length - 1; i >= 0; i--) {
      if (count == 3 || (count > 3 && (count - 3) % 2 == 0)) {
        buffer.write(',');
      }
      buffer.write(intPart[i]);
      count++;
    }

    final formatted = buffer.toString().split('').reversed.join('');
    return decPart.isNotEmpty && decimals > 0
        ? '$formatted.$decPart'
        : formatted;
  }
}


class WesternMarketFormatter implements MarketFormatter {
  WesternMarketFormatter({required this.currencySymbol});

  final String currencySymbol;

  @override
  String formatCurrency(double amount, {int? decimals}) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (absAmount >= 1e12) {
      return '$sign$currencySymbol${_formatNumber(absAmount / 1e12, decimals ?? 2)}T';
    } else if (absAmount >= 1e9) {
      return '$sign$currencySymbol${_formatNumber(absAmount / 1e9, decimals ?? 2)}B';
    } else if (absAmount >= 1e6) {
      return '$sign$currencySymbol${_formatNumber(absAmount / 1e6, decimals ?? 2)}M';
    } else if (absAmount >= 1e3) {
      return '$sign$currencySymbol${_formatNumber(absAmount / 1e3, decimals ?? 1)}K';
    } else {
      return '$sign$currencySymbol${_formatNumber(absAmount, decimals ?? 2)}';
    }
  }

  @override
  String formatLargeNumber(double amount) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (absAmount >= 1e12) return '$sign${_formatNumber(absAmount / 1e12, 2)}T';
    if (absAmount >= 1e9) return '$sign${_formatNumber(absAmount / 1e9, 2)}B';
    if (absAmount >= 1e6) return '$sign${_formatNumber(absAmount / 1e6, 2)}M';
    if (absAmount >= 1e3) return '$sign${_formatNumber(absAmount / 1e3, 1)}K';
    return '$sign${_formatNumber(absAmount, 0)}';
  }

  @override
  String formatPrice(double price, {int? decimals}) {
    return '$currencySymbol${_formatNumber(price, decimals ?? 2)}';
  }

  @override
  String formatPercentage(double pct, {int decimals = 2, bool showSign = true}) {
    final sign = showSign && pct > 0 ? '+' : '';
    return '$sign${_formatNumber(pct, decimals)}%';
  }

  @override
  String formatVolume(double volume) {
    return formatLargeNumber(volume);
  }

  @override
  String formatChange(double change, double changePercent) {
    final sign = change >= 0 ? '+' : '';
    return '$sign${formatPrice(change.abs())} ($sign${_formatNumber(changePercent, 2)}%)';
  }

  String _formatNumber(double value, int decimals) {
    return value.toStringAsFixed(decimals);
  }
}


class CryptoMarketFormatter implements MarketFormatter {
  @override
  String formatCurrency(double amount, {int? decimals}) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (absAmount >= 1e9) {
      return '$sign\$${_formatNumber(absAmount / 1e9, decimals ?? 2)}B';
    } else if (absAmount >= 1e6) {
      return '$sign\$${_formatNumber(absAmount / 1e6, decimals ?? 2)}M';
    } else if (absAmount >= 1e3) {
      return '$sign\$${_formatNumber(absAmount / 1e3, decimals ?? 1)}K';
    } else {
      return '$sign\$${_formatNumber(absAmount, decimals ?? 2)}';
    }
  }

  @override
  String formatLargeNumber(double amount) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (absAmount >= 1e9) return '$sign${_formatNumber(absAmount / 1e9, 2)}B';
    if (absAmount >= 1e6) return '$sign${_formatNumber(absAmount / 1e6, 2)}M';
    if (absAmount >= 1e3) return '$sign${_formatNumber(absAmount / 1e3, 1)}K';
    return '$sign${_formatNumber(absAmount, 0)}';
  }

  @override
  String formatPrice(double price, {int? decimals}) {
    if (decimals != null) {
      return '\$${_formatNumber(price, decimals)}';
    }

    final absPrice = price.abs();
    final sign = price < 0 ? '-' : '';

    if (absPrice < 0.00001) {
      return '$sign\$${_formatNumber(absPrice, 10)}'; // Ultra-small (e.g., SHIB)
    } else if (absPrice < 0.001) {
      return '$sign\$${_formatNumber(absPrice, 8)}'; // Micro tokens
    } else if (absPrice < 0.1) {
      return '$sign\$${_formatNumber(absPrice, 6)}'; // Small tokens (DOGE, etc.)
    } else if (absPrice < 1) {
      return '$sign\$${_formatNumber(absPrice, 5)}'; // Sub-dollar
    } else if (absPrice < 100) {
      return '$sign\$${_formatNumber(absPrice, 4)}'; // Mid-price (1-100)
    } else {
      return '$sign\$${_formatNumber(absPrice, 2)}'; // High-price (BTC, ETH)
    }
  }

  @override
  String formatPercentage(double pct, {int decimals = 2, bool showSign = true}) {
    final sign = showSign && pct > 0 ? '+' : '';
    return '$sign${_formatNumber(pct, decimals)}%';
  }

  @override
  String formatVolume(double volume) {
    return formatLargeNumber(volume);
  }

  @override
  String formatChange(double change, double changePercent) {
    final sign = change >= 0 ? '+' : '';
    return '$sign${formatPrice(change.abs())} ($sign${_formatNumber(changePercent, 2)}%)';
  }

  String _formatNumber(double value, int decimals) {
    var str = value.toStringAsFixed(decimals);
    if (decimals > 2 && str.contains('.')) {
      str = str.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return str;
  }
}


extension NumberFormatExtensions on double {
  String toCurrency(MarketRegime market, {int? decimals}) {
    return MarketFormatterFactory.forMarket(market)
        .formatCurrency(this, decimals: decimals);
  }

  String toPercent({int decimals = 2, bool showSign = true}) {
    final sign = showSign && this > 0 ? '+' : '';
    return '$sign${toStringAsFixed(decimals)}%';
  }

  String toCompact({int decimals = 1}) {
    final abs = this.abs();
    final sign = this < 0 ? '-' : '';

    if (abs >= 1e12) return '$sign${(abs / 1e12).toStringAsFixed(decimals)}T';
    if (abs >= 1e9) return '$sign${(abs / 1e9).toStringAsFixed(decimals)}B';
    if (abs >= 1e6) return '$sign${(abs / 1e6).toStringAsFixed(decimals)}M';
    if (abs >= 1e3) return '$sign${(abs / 1e3).toStringAsFixed(decimals)}K';
    return '$sign${toStringAsFixed(0)}';
  }
}
