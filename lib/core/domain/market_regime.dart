enum MarketRegime {
  usa(
    displayName: 'United States',
    shortName: 'USA',
    flag: '🇺🇸',
    currencyCode: 'USD',
    currencySymbol: '\$',
    locale: 'en_US',
    primaryIndex: 'S&P 500',
    primaryIndexSymbol: '^GSPC',
    secondaryIndices: [
      'Dow Jones',
      'NASDAQ Composite',
      'Russell 2000',
    ],
    regulatoryBody: 'SEC / FINRA',
    timezone: 'America/New_York',
    marketOpenHour: 9,
    marketOpenMinute: 30,
    marketCloseHour: 16,
    marketCloseMinute: 0,
    workingDays: [1, 2, 3, 4, 5], // Mon-Fri
  ),
  india(
    displayName: 'India',
    shortName: 'IND',
    flag: '🇮🇳',
    currencyCode: 'INR',
    currencySymbol: '₹',
    locale: 'en_IN',
    primaryIndex: 'NIFTY 50',
    primaryIndexSymbol: '^NSEI',
    secondaryIndices: [
      'SENSEX',
      'BANK NIFTY',
      'NIFTY IT',
      'NIFTY MIDCAP',
    ],
    regulatoryBody: 'SEBI',
    timezone: 'Asia/Kolkata',
    marketOpenHour: 9,
    marketOpenMinute: 15,
    marketCloseHour: 15,
    marketCloseMinute: 30,
    workingDays: [1, 2, 3, 4, 5], // Mon-Fri
  ),
  uk(
    displayName: 'United Kingdom',
    shortName: 'UK',
    flag: '🇬🇧',
    currencyCode: 'GBP',
    currencySymbol: '£',
    locale: 'en_GB',
    primaryIndex: 'FTSE 100',
    primaryIndexSymbol: '^FTSE',
    secondaryIndices: [
      'FTSE 250',
      'FTSE All-Share',
    ],
    regulatoryBody: 'FCA',
    timezone: 'Europe/London',
    marketOpenHour: 8,
    marketOpenMinute: 0,
    marketCloseHour: 16,
    marketCloseMinute: 30,
    workingDays: [1, 2, 3, 4, 5], // Mon-Fri
  ),
  crypto(
    displayName: 'Cryptocurrency',
    shortName: 'CRYPTO',
    flag: '🌐',
    currencyCode: 'USD',
    currencySymbol: '\$',
    locale: 'en_US',
    primaryIndex: 'Total Market Cap',
    primaryIndexSymbol: 'TOTAL',
    secondaryIndices: [
      'BTC Dominance',
      'DeFi Market Cap',
      'Alt Season Index',
    ],
    regulatoryBody: 'Decentralized',
    timezone: 'UTC',
    marketOpenHour: 0,
    marketOpenMinute: 0,
    marketCloseHour: 23,
    marketCloseMinute: 59,
    workingDays: [1, 2, 3, 4, 5, 6, 7], // 24/7
  );

  const MarketRegime({
    required this.displayName,
    required this.shortName,
    required this.flag,
    required this.currencyCode,
    required this.currencySymbol,
    required this.locale,
    required this.primaryIndex,
    required this.primaryIndexSymbol,
    required this.secondaryIndices,
    required this.regulatoryBody,
    required this.timezone,
    required this.marketOpenHour,
    required this.marketOpenMinute,
    required this.marketCloseHour,
    required this.marketCloseMinute,
    required this.workingDays,
  });

  final String displayName;
  final String shortName;
  final String flag;
  final String currencyCode;
  final String currencySymbol;
  final String locale;
  final String primaryIndex;
  final String primaryIndexSymbol;
  final List<String> secondaryIndices;
  final String regulatoryBody;
  final String timezone;
  final int marketOpenHour;
  final int marketOpenMinute;
  final int marketCloseHour;
  final int marketCloseMinute;
  final List<int> workingDays; // 1=Monday, 7=Sunday

  bool get isMarketOpen {
    final now = DateTime.now().toUtc();
    if (this == MarketRegime.crypto) return true;

    if (!workingDays.contains(now.weekday)) return false;

    final hourNow = now.hour;
    final minuteNow = now.minute;

    final openMinutes = marketOpenHour * 60 + marketOpenMinute;
    final closeMinutes = marketCloseHour * 60 + marketCloseMinute;
    final currentMinutes = hourNow * 60 + minuteNow;

    return currentMinutes >= openMinutes && currentMinutes <= closeMinutes;
  }

  String get systematicInvestmentTerm {
    switch (this) {
      case MarketRegime.usa:
        return 'Dollar Cost Averaging (DCA)';
      case MarketRegime.india:
        return 'Systematic Investment Plan (SIP)';
      case MarketRegime.uk:
        return 'Regular Savings Plan';
      case MarketRegime.crypto:
        return 'Dollar Cost Averaging (DCA)';
    }
  }

  String get brokerageAccountTerm {
    switch (this) {
      case MarketRegime.usa:
        return 'Brokerage Account';
      case MarketRegime.india:
        return 'Demat Account';
      case MarketRegime.uk:
        return 'Share Dealing Account';
      case MarketRegime.crypto:
        return 'Exchange Account';
    }
  }

  String get retirementVehicleTerm {
    switch (this) {
      case MarketRegime.usa:
        return '401(k) / IRA';
      case MarketRegime.india:
        return 'PPF / NPS';case MarketRegime.uk:
        return 'ISA / SIPP';
      case MarketRegime.crypto:
        return 'N/A';
    }
  }
}
