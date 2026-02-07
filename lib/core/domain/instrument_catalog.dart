import 'instrument.dart';
import 'market_regime.dart';

class InstrumentCatalog {
  InstrumentCatalog._();

  static const List<Instrument> indiaInstruments = [
    Instrument(
      symbol: 'RELIANCE',
      name: 'Reliance Industries Ltd',
      type: InstrumentType.stock,
      sector: Sector.energy,
      market: MarketRegime.india,
      basePrice: 2450.50,
      volatility: 0.28,
      exchange: 'NSE',
      description:
          'India\'s largest private sector company. Diversified conglomerate with interests in petrochemicals, refining, oil & gas, telecom (Jio), and retail.',
    ),
    Instrument(
      symbol: 'TCS',
      name: 'Tata Consultancy Services Ltd',
      type: InstrumentType.stock,
      sector: Sector.technology,
      market: MarketRegime.india,
      basePrice: 3680.75,
      volatility: 0.24,
      exchange: 'NSE',
      description:
          'Leading global IT services, consulting, and business solutions organization. Part of the Tata Group.',
    ),
    Instrument(
      symbol: 'HDFCBANK',
      name: 'HDFC Bank Ltd',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.india,
      basePrice: 1625.30,
      volatility: 0.22,
      exchange: 'NSE',
      description:
          'India\'s largest private sector bank by assets. Offers wide range of banking and financial services.',
    ),
    Instrument(
      symbol: 'INFY',
      name: 'Infosys Ltd',
      type: InstrumentType.stock,
      sector: Sector.technology,
      market: MarketRegime.india,
      basePrice: 1480.20,
      volatility: 0.26,
      exchange: 'NSE',
      description:
          'Global leader in next-generation digital services and consulting. Second largest IT services company in India.',
    ),
    Instrument(
      symbol: 'BHARTIARTL',
      name: 'Bharti Airtel Ltd',
      type: InstrumentType.stock,
      sector: Sector.communicationServices,
      market: MarketRegime.india,
      basePrice: 892.40,
      volatility: 0.30,
      exchange: 'NSE',
      description:
          'Leading telecom services provider with presence across India and Africa. Competes with Reliance Jio.',
    ),
    Instrument(
      symbol: 'ICICIBANK',
      name: 'ICICI Bank Ltd',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.india,
      basePrice: 980.60,
      volatility: 0.27,
      exchange: 'NSE',
      description:
          'Second largest private sector bank. Provides comprehensive banking and financial services.',
    ),
    Instrument(
      symbol: 'HINDUNILVR',
      name: 'Hindustan Unilever Ltd',
      type: InstrumentType.stock,
      sector: Sector.consumerDefensive,
      market: MarketRegime.india,
      basePrice: 2385.80,
      volatility: 0.20,
      exchange: 'NSE',
      description:
          'India\'s largest FMCG company. Sells products across home & personal care, foods & refreshment.',
    ),
    Instrument(
      symbol: 'ITC',
      name: 'ITC Ltd',
      type: InstrumentType.stock,
      sector: Sector.consumerDefensive,
      market: MarketRegime.india,
      basePrice: 412.50,
      volatility: 0.19,
      exchange: 'NSE',
      description:
          'Diversified conglomerate with presence in FMCG, hotels, packaging, paperboards, and agri-business.',
    ),
    Instrument(
      symbol: 'LT',
      name: 'Larsen & Toubro Ltd',
      type: InstrumentType.stock,
      sector: Sector.industrials,
      market: MarketRegime.india,
      basePrice: 3245.90,
      volatility: 0.29,
      exchange: 'NSE',
      description:
          'Leading engineering, construction, and manufacturing conglomerate. Builds India\'s infrastructure.',
    ),
    Instrument(
      symbol: 'SBIN',
      name: 'State Bank of India',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.india,
      basePrice: 598.70,
      volatility: 0.32,
      exchange: 'NSE',
      description:
          'India\'s largest public sector bank. Government-owned with extensive branch network nationwide.',
    ),
    Instrument(
      symbol: 'TATASTEEL',
      name: 'Tata Steel Ltd',
      type: InstrumentType.stock,
      sector: Sector.basicMaterials,
      market: MarketRegime.india,
      basePrice: 128.40,
      volatility: 0.38,
      exchange: 'NSE',
      description:
          'Among India\'s biggest steel producers. Cyclical stock sensitive to commodity prices and global demand.',
    ),
    Instrument(
      symbol: 'ASIANPAINT',
      name: 'Asian Paints Ltd',
      type: InstrumentType.stock,
      sector: Sector.basicMaterials,
      market: MarketRegime.india,
      basePrice: 2920.10,
      volatility: 0.25,
      exchange: 'NSE',
      description:
          'India\'s largest paint company. Strong brand, high margins, and consistent growth track record.',
    ),
    Instrument(
      symbol: 'AXISBANK',
      name: 'Axis Bank Ltd',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.india,
      basePrice: 1045.20,
      volatility: 0.33,
      exchange: 'NSE',
      description:
          'Third largest private sector bank. Known for retail and corporate banking services.',
    ),
    Instrument(
      symbol: 'MARUTI',
      name: 'Maruti Suzuki India Ltd',
      type: InstrumentType.stock,
      sector: Sector.consumerCyclical,
      market: MarketRegime.india,
      basePrice: 10245.50,
      volatility: 0.31,
      exchange: 'NSE',
      description:
          'India\'s largest passenger vehicle manufacturer. JV between Suzuki Motor Corp and Govt of India.',
    ),
    Instrument(
      symbol: 'WIPRO',
      name: 'Wipro Ltd',
      type: InstrumentType.stock,
      sector: Sector.technology,
      market: MarketRegime.india,
      basePrice: 425.30,
      volatility: 0.29,
      exchange: 'NSE',
      description:
          'Leading global IT services company. Provides digital, cloud, and cybersecurity solutions.',
    ),
    Instrument(
      symbol: 'NIFTYBEES',
      name: 'Nippon India ETF Nifty BeES',
      type: InstrumentType.etf,
      sector: Sector.unknown,
      market: MarketRegime.india,
      basePrice: 246.80,
      volatility: 0.18,
      exchange: 'NSE',
      description:
          'India\'s first exchange-traded fund. Tracks Nifty 50 index performance. Ideal for passive investing.',
    ),
    Instrument(
      symbol: 'GOLDBEES',
      name: 'Nippon India ETF Gold BeES',
      type: InstrumentType.etf,
      sector: Sector.basicMaterials,
      market: MarketRegime.india,
      basePrice: 58.90,
      volatility: 0.15,
      exchange: 'NSE',
      description:
          'Gold ETF that tracks domestic gold prices. Alternative to physical gold, trades like stock.',
    ),
    Instrument(
      symbol: 'ONGC',
      name: 'Oil and Natural Gas Corporation Ltd',
      type: InstrumentType.stock,
      sector: Sector.energy,
      market: MarketRegime.india,
      basePrice: 178.60,
      volatility: 0.35,
      exchange: 'NSE',
      description:
          'India\'s largest oil and gas exploration company. Government PSU sensitive to crude oil prices.',
    ),
    Instrument(
      symbol: 'ZOMATO',
      name: 'Zomato Ltd',
      type: InstrumentType.stock,
      sector: Sector.consumerCyclical,
      market: MarketRegime.india,
      basePrice: 128.75,
      volatility: 0.62,
      exchange: 'NSE',
      description:
          'Food delivery platform. High-growth tech stock with high volatility. Teaching risk tolerance.',
    ),
    Instrument(
      symbol: 'PAYTM',
      name: 'One 97 Communications Ltd (Paytm)',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.india,
      basePrice: 584.20,
      volatility: 0.71,
      exchange: 'NSE',
      description:
          'Digital payments and financial services platform. Highly volatile fintech stock.',
    ),
  ];

  static const List<Instrument> usaInstruments = [
    Instrument(
      symbol: 'AAPL',
      name: 'Apple Inc',
      type: InstrumentType.stock,
      sector: Sector.technology,
      market: MarketRegime.usa,
      basePrice: 178.50,
      volatility: 0.28,
      exchange: 'NASDAQ',
      description:
          'World\'s most valuable company. Designs and sells iPhones, Macs, iPads, wearables, and services.',
    ),
    Instrument(
      symbol: 'MSFT',
      name: 'Microsoft Corporation',
      type: InstrumentType.stock,
      sector: Sector.technology,
      market: MarketRegime.usa,
      basePrice: 378.25,
      volatility: 0.26,
      exchange: 'NASDAQ',
      description:
          'Leading enterprise software company. Cloud (Azure), Office 365, Windows, LinkedIn, GitHub.',
    ),
    Instrument(
      symbol: 'GOOGL',
      name: 'Alphabet Inc Class A',
      type: InstrumentType.stock,
      sector: Sector.communicationServices,
      market: MarketRegime.usa,
      basePrice: 140.30,
      volatility: 0.30,
      exchange: 'NASDAQ',
      description:
          'Parent company of Google. Dominates search, advertising, YouTube, Android, and cloud (GCP).',
    ),
    Instrument(
      symbol: 'AMZN',
      name: 'Amazon.com Inc',
      type: InstrumentType.stock,
      sector: Sector.consumerCyclical,
      market: MarketRegime.usa,
      basePrice: 152.80,
      volatility: 0.35,
      exchange: 'NASDAQ',
      description:
          'Global e-commerce and cloud computing giant. AWS dominates cloud infrastructure market.',
    ),
    Instrument(
      symbol: 'META',
      name: 'Meta Platforms Inc',
      type: InstrumentType.stock,
      sector: Sector.communicationServices,
      market: MarketRegime.usa,
      basePrice: 356.70,
      volatility: 0.42,
      exchange: 'NASDAQ',
      description:
          'Social media conglomerate (Facebook, Instagram, WhatsApp). Investing heavily in metaverse/VR.',
    ),
    Instrument(
      symbol: 'TSLA',
      name: 'Tesla Inc',
      type: InstrumentType.stock,
      sector: Sector.consumerCyclical,
      market: MarketRegime.usa,
      basePrice: 248.90,
      volatility: 0.58,
      exchange: 'NASDAQ',
      description:
          'Electric vehicle and clean energy company. Highly volatile, led by Elon Musk.',
    ),
    Instrument(
      symbol: 'NVDA',
      name: 'NVIDIA Corporation',
      type: InstrumentType.stock,
      sector: Sector.technology,
      market: MarketRegime.usa,
      basePrice: 502.40,
      volatility: 0.48,
      exchange: 'NASDAQ',
      description:
          'Leader in GPUs for gaming, data centers, and AI. Powering the AI revolution.',
    ),
    Instrument(
      symbol: 'JPM',
      name: 'JPMorgan Chase & Co',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.usa,
      basePrice: 158.40,
      volatility: 0.27,
      exchange: 'NYSE',
      description:
          'Largest US bank by assets. Investment banking, commercial banking, asset management.',
    ),
    Instrument(
      symbol: 'JNJ',
      name: 'Johnson & Johnson',
      type: InstrumentType.stock,
      sector: Sector.healthcare,
      market: MarketRegime.usa,
      basePrice: 156.20,
      volatility: 0.16,
      exchange: 'NYSE',
      description:
          'Pharmaceutical and consumer health giant. Defensive stock, stable dividends.',
    ),
    Instrument(
      symbol: 'V',
      name: 'Visa Inc Class A',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.usa,
      basePrice: 252.30,
      volatility: 0.24,
      exchange: 'NYSE',
      description:
          'Global payments technology company. Processes digital payments worldwide.',
    ),
    Instrument(
      symbol: 'PG',
      name: 'Procter & Gamble Co',
      type: InstrumentType.stock,
      sector: Sector.consumerDefensive,
      market: MarketRegime.usa,
      basePrice: 165.80,
      volatility: 0.18,
      exchange: 'NYSE',
      description:
          'Consumer goods giant (Gillette, Tide, Pampers). Defensive, reliable dividends.',
    ),
    Instrument(
      symbol: 'XOM',
      name: 'Exxon Mobil Corporation',
      type: InstrumentType.stock,
      sector: Sector.energy,
      market: MarketRegime.usa,
      basePrice: 108.90,
      volatility: 0.32,
      exchange: 'NYSE',
      description:
          'Largest US oil company. Sensitive to crude oil prices and geopolitical events.',
    ),
    Instrument(
      symbol: 'WMT',
      name: 'Walmart Inc',
      type: InstrumentType.stock,
      sector: Sector.consumerDefensive,
      market: MarketRegime.usa,
      basePrice: 162.50,
      volatility: 0.22,
      exchange: 'NYSE',
      description:
          'World\'s largest retailer. Defensive stock, consistent revenue even in recessions.',
    ),
    Instrument(
      symbol: 'COIN',
      name: 'Coinbase Global Inc',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.usa,
      basePrice: 84.30,
      volatility: 0.82,
      exchange: 'NASDAQ',
      description:
          'Largest US crypto exchange. Extremely volatile, correlated with Bitcoin price.',
    ),
    Instrument(
      symbol: 'NFLX',
      name: 'Netflix Inc',
      type: InstrumentType.stock,
      sector: Sector.communicationServices,
      market: MarketRegime.usa,
      basePrice: 428.40,
      volatility: 0.40,
      exchange: 'NASDAQ',
      description:
          'Streaming entertainment leader. High-growth stock, sensitive to subscriber numbers.',
    ),
    Instrument(
      symbol: 'SPY',
      name: 'SPDR S&P 500 ETF Trust',
      type: InstrumentType.etf,
      sector: Sector.unknown,
      market: MarketRegime.usa,
      basePrice: 458.20,
      volatility: 0.17,
      exchange: 'NYSE',
      description:
          'Largest and most liquid ETF. Tracks S&P 500 index. Core holding for passive investors.',
    ),
    Instrument(
      symbol: 'GLD',
      name: 'SPDR Gold Trust',
      type: InstrumentType.etf,
      sector: Sector.basicMaterials,
      market: MarketRegime.usa,
      basePrice: 187.40,
      volatility: 0.14,
      exchange: 'NYSE',
      description:
          'Gold ETF tracking gold bullion prices. Inflation hedge, safe-haven asset.',
    ),
    Instrument(
      symbol: 'BA',
      name: 'The Boeing Company',
      type: InstrumentType.stock,
      sector: Sector.industrials,
      market: MarketRegime.usa,
      basePrice: 182.60,
      volatility: 0.36,
      exchange: 'NYSE',
      description:
          'Aerospace and defense giant. Commercial aircraft (737, 777) and military contracts.',
    ),
    Instrument(
      symbol: 'AMT',
      name: 'American Tower Corporation',
      type: InstrumentType.stock,
      sector: Sector.realEstate,
      market: MarketRegime.usa,
      basePrice: 198.70,
      volatility: 0.28,
      exchange: 'NYSE',
      description:
          'REIT owning cell towers globally. Provides infrastructure for wireless networks.',
    ),
    Instrument(
      symbol: 'AMD',
      name: 'Advanced Micro Devices Inc',
      type: InstrumentType.stock,
      sector: Sector.technology,
      market: MarketRegime.usa,
      basePrice: 164.30,
      volatility: 0.52,
      exchange: 'NASDAQ',
      description:
          'Semiconductor company competing with Intel and NVIDIA. CPUs and GPUs for gaming/data centers.',
    ),
  ];

  static const List<Instrument> ukInstruments = [
    Instrument(
      symbol: 'SHEL.L',
      name: 'Shell plc',
      type: InstrumentType.stock,
      sector: Sector.energy,
      market: MarketRegime.uk,
      basePrice: 2658.50,
      volatility: 0.29,
      exchange: 'LSE',
      description:
          'British-Dutch oil and gas giant. One of Europe\'s largest energy companies.',
    ),
    Instrument(
      symbol: 'HSBA.L',
      name: 'HSBC Holdings plc',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.uk,
      basePrice: 648.20,
      volatility: 0.28,
      exchange: 'LSE',
      description:
          'One of world\'s largest banking and financial services organizations. Headquartered in London.',
    ),
    Instrument(
      symbol: 'AZN.L',
      name: 'AstraZeneca PLC',
      type: InstrumentType.stock,
      sector: Sector.healthcare,
      market: MarketRegime.uk,
      basePrice: 11450.00,
      volatility: 0.25,
      exchange: 'LSE',
      description:
          'Global pharmaceutical giant. COVID-19 vaccine producer, oncology and rare disease drugs.',
    ),
    Instrument(
      symbol: 'BP.L',
      name: 'BP plc',
      type: InstrumentType.stock,
      sector: Sector.energy,
      market: MarketRegime.uk,
      basePrice: 498.30,
      volatility: 0.32,
      exchange: 'LSE',
      description:
          'British oil and gas supermajor. Transitioning to renewable energy.',
    ),
    Instrument(
      symbol: 'ULVR.L',
      name: 'Unilever PLC',
      type: InstrumentType.stock,
      sector: Sector.consumerDefensive,
      market: MarketRegime.uk,
      basePrice: 4285.00,
      volatility: 0.19,
      exchange: 'LSE',
      description:
          'Consumer goods company (Dove, Knorr, Lipton). Defensive stock with global brands.',
    ),
    Instrument(
      symbol: 'GSK.L',
      name: 'GSK plc',
      type: InstrumentType.stock,
      sector: Sector.healthcare,
      market: MarketRegime.uk,
      basePrice: 1548.20,
      volatility: 0.23,
      exchange: 'LSE',
      description:
          'Global pharmaceutical company (formerly GlaxoSmithKline). Vaccines and specialty medicines.',
    ),
    Instrument(
      symbol: 'DGE.L',
      name: 'Diageo plc',
      type: InstrumentType.stock,
      sector: Sector.consumerDefensive,
      market: MarketRegime.uk,
      basePrice: 2890.00,
      volatility: 0.20,
      exchange: 'LSE',
      description:
          'World\'s largest spirits producer (Johnnie Walker, Guinness, Smirnoff). Stable, defensive.',
    ),
    Instrument(
      symbol: 'BARC.L',
      name: 'Barclays PLC',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.uk,
      basePrice: 185.40,
      volatility: 0.34,
      exchange: 'LSE',
      description:
          'British multinational investment bank and financial services company.',
    ),
    Instrument(
      symbol: 'LLOY.L',
      name: 'Lloyds Banking Group plc',
      type: InstrumentType.stock,
      sector: Sector.financialServices,
      market: MarketRegime.uk,
      basePrice: 54.60,
      volatility: 0.31,
      exchange: 'LSE',
      description:
          'Major UK retail and commercial bank. Largest mortgage lender in UK.',
    ),
    Instrument(
      symbol: 'VOD.L',
      name: 'Vodafone Group Plc',
      type: InstrumentType.stock,
      sector: Sector.communicationServices,
      market: MarketRegime.uk,
      basePrice: 74.80,
      volatility: 0.33,
      exchange: 'LSE',
      description:
          'Global telecommunications company. Mobile and fixed-line networks across Europe and Africa.',
    ),
    Instrument(
      symbol: 'RIO.L',
      name: 'Rio Tinto Group',
      type: InstrumentType.stock,
      sector: Sector.basicMaterials,
      market: MarketRegime.uk,
      basePrice: 5245.00,
      volatility: 0.35,
      exchange: 'LSE',
      description:
          'Anglo-Australian multinational mining corporation. Iron ore, aluminium, copper.',
    ),
    Instrument(
      symbol: 'GLEN.L',
      name: 'Glencore plc',
      type: InstrumentType.stock,
      sector: Sector.basicMaterials,
      market: MarketRegime.uk,
      basePrice: 438.50,
      volatility: 0.37,
      exchange: 'LSE',
      description:
          'Swiss-based mining and commodity trading company. Highly cyclical, sensitive to commodities.',
    ),
    Instrument(
      symbol: 'TSCO.L',
      name: 'Tesco PLC',
      type: InstrumentType.stock,
      sector: Sector.consumerDefensive,
      market: MarketRegime.uk,
      basePrice: 292.40,
      volatility: 0.22,
      exchange: 'LSE',
      description:
          'Largest UK supermarket chain. Defensive retailer with stable revenue streams.',
    ),
    Instrument(
      symbol: 'NG.L',
      name: 'National Grid plc',
      type: InstrumentType.stock,
      sector: Sector.utilities,
      market: MarketRegime.uk,
      basePrice: 958.20,
      volatility: 0.17,
      exchange: 'LSE',
      description:
          'Owns and operates electricity/gas transmission networks in UK and US. Regulated utility.',
    ),
    Instrument(
      symbol: 'OCDO.L',
      name: 'Ocado Group plc',
      type: InstrumentType.stock,
      sector: Sector.consumerCyclical,
      market: MarketRegime.uk,
      basePrice: 694.80,
      volatility: 0.58,
      exchange: 'LSE',
      description:
          'Online grocery retailer and technology platform. High-growth, high-volatility stock.',
    ),
    Instrument(
      symbol: 'WIZZ.L',
      name: 'Wizz Air Holdings PLC',
      type: InstrumentType.stock,
      sector: Sector.consumerCyclical,
      market: MarketRegime.uk,
      basePrice: 1845.00,
      volatility: 0.64,
      exchange: 'LSE',
      description:
          'Ultra low-cost airline. Highly volatile, sensitive to fuel prices and travel demand.',
    ),
    Instrument(
      symbol: 'VUKE.L',
      name: 'Vanguard FTSE 100 ETF',
      type: InstrumentType.etf,
      sector: Sector.unknown,
      market: MarketRegime.uk,
      basePrice: 3824.00,
      volatility: 0.16,
      exchange: 'LSE',
      description:
          'Tracks FTSE 100 index. Low-cost passive investing in UK\'s largest companies.',
    ),
    Instrument(
      symbol: 'LAND.L',
      name: 'Land Securities Group plc',
      type: InstrumentType.stock,
      sector: Sector.realEstate,
      market: MarketRegime.uk,
      basePrice: 682.00,
      volatility: 0.30,
      exchange: 'LSE',
      description:
          'UK\'s largest commercial property development and investment company. REIT.',
    ),
    Instrument(
      symbol: 'BA.L',
      name: 'BAE Systems plc',
      type: InstrumentType.stock,
      sector: Sector.industrials,
      market: MarketRegime.uk,
      basePrice: 1268.00,
      volatility: 0.26,
      exchange: 'LSE',
      description:
          'British multinational defense, aerospace, and security company.',
    ),
    Instrument(
      symbol: 'BRBY.L',
      name: 'Burberry Group plc',
      type: InstrumentType.stock,
      sector: Sector.consumerCyclical,
      market: MarketRegime.uk,
      basePrice: 1348.00,
      volatility: 0.36,
      exchange: 'LSE',
      description:
          'British luxury fashion house. Cyclical, sensitive to luxury spending trends.',
    ),
  ];

  static const List<Instrument> cryptoInstruments = [
    Instrument(
      symbol: 'BTC/USD',
      name: 'Bitcoin',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 43280.50,
      volatility: 0.68,
      exchange: 'Binance',
      description:
          'First and largest cryptocurrency. Digital gold, store of value, decentralized currency.',
    ),
    Instrument(
      symbol: 'ETH/USD',
      name: 'Ethereum',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 2295.80,
      volatility: 0.75,
      exchange: 'Binance',
      description:
          'Leading smart contract platform. Powers DeFi, NFTs, and decentralized applications.',
    ),
    Instrument(
      symbol: 'BNB/USD',
      name: 'BNB (Binance Coin)',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 312.40,
      volatility: 0.72,
      exchange: 'Binance',
      description:
          'Binance exchange token. Used for trading fee discounts and Binance Smart Chain.',
    ),
    Instrument(
      symbol: 'SOL/USD',
      name: 'Solana',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 108.60,
      volatility: 0.95,
      exchange: 'Binance',
      description:
          'High-speed blockchain platform. Ethereum competitor, focused on scalability.',
    ),
    Instrument(
      symbol: 'ADA/USD',
      name: 'Cardano',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 0.548,
      volatility: 0.82,
      exchange: 'Binance',
      description:
          'Proof-of-stake blockchain. Academic approach, focus on sustainability and governance.',
    ),
    Instrument(
      symbol: 'XRP/USD',
      name: 'Ripple',
      type: InstrumentType.crypto,
      sector: Sector.financialServices,
      market: MarketRegime.crypto,
      basePrice: 0.614,
      volatility: 0.88,
      exchange: 'Binance',
      description:
          'Digital payment protocol. Targets cross-border payments for banks.',
    ),
    Instrument(
      symbol: 'AVAX/USD',
      name: 'Avalanche',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 38.20,
      volatility: 0.92,
      exchange: 'Binance',
      description:
          'Smart contract platform competing with Ethereum. Fast finality, low fees.',
    ),
    Instrument(
      symbol: 'DOT/USD',
      name: 'Polkadot',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 7.45,
      volatility: 0.86,
      exchange: 'Binance',
      description:
          'Multi-chain protocol. Enables cross-blockchain communication and interoperability.',
    ),
    Instrument(
      symbol: 'MATIC/USD',
      name: 'Polygon',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 0.928,
      volatility: 0.94,
      exchange: 'Binance',
      description:
          'Ethereum scaling solution (Layer 2). Faster and cheaper than Ethereum mainnet.',
    ),
    Instrument(
      symbol: 'USDT/USD',
      name: 'Tether',
      type: InstrumentType.crypto,
      sector: Sector.financialServices,
      market: MarketRegime.crypto,
      basePrice: 1.0,
      volatility: 0.008, // Nearly zero volatility (pegged to USD)
      exchange: 'Binance',
      description:
          'Largest stablecoin pegged to US dollar. Used for trading and as safe haven.',
    ),
    Instrument(
      symbol: 'USDC/USD',
      name: 'USD Coin',
      type: InstrumentType.crypto,
      sector: Sector.financialServices,
      market: MarketRegime.crypto,
      basePrice: 1.0,
      volatility: 0.006,
      exchange: 'Coinbase',
      description:
          'Regulated stablecoin backed 1:1 by USD reserves. Issued by Circle.',
    ),
    Instrument(
      symbol: 'LINK/USD',
      name: 'Chainlink',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 15.28,
      volatility: 0.90,
      exchange: 'Binance',
      description:
          'Decentralized oracle network. Connects smart contracts to real-world data.',
    ),
    Instrument(
      symbol: 'UNI/USD',
      name: 'Uniswap',
      type: InstrumentType.crypto,
      sector: Sector.financialServices,
      market: MarketRegime.crypto,
      basePrice: 9.62,
      volatility: 0.96,
      exchange: 'Binance',
      description:
          'Leading decentralized exchange (DEX) protocol. Powers automated market making.',
    ),
    Instrument(
      symbol: 'AAVE/USD',
      name: 'Aave',
      type: InstrumentType.crypto,
      sector: Sector.financialServices,
      market: MarketRegime.crypto,
      basePrice: 102.40,
      volatility: 0.98,
      exchange: 'Binance',
      description:
          'Decentralized lending protocol. Earn interest on deposits, borrow against collateral.',
    ),
    Instrument(
      symbol: 'DOGE/USD',
      name: 'Dogecoin',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 0.0812,
      volatility: 1.15,
      exchange: 'Binance',
      description:
          'Original meme coin. Extremely volatile, driven by social media sentiment.',
    ),
    Instrument(
      symbol: 'SHIB/USD',
      name: 'Shiba Inu',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 0.00001042,
      volatility: 1.28,
      exchange: 'Binance',
      description:
          'Meme token inspired by Dogecoin. Teaching example of speculative mania.',
    ),
    Instrument(
      symbol: 'ARB/USD',
      name: 'Arbitrum',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 1.38,
      volatility: 1.02,
      exchange: 'Binance',
      description:
          'Ethereum Layer 2 scaling solution. Optimistic rollup for faster, cheaper transactions.',
    ),
    Instrument(
      symbol: 'CRO/USD',
      name: 'Cronos',
      type: InstrumentType.crypto,
      sector: Sector.financialServices,
      market: MarketRegime.crypto,
      basePrice: 0.132,
      volatility: 0.94,
      exchange: 'Crypto.com',
      description:
          'Crypto.com exchange token. Used for trading fee discounts and staking rewards.',
    ),
    Instrument(
      symbol: 'XMR/USD',
      name: 'Monero',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 162.50,
      volatility: 0.80,
      exchange: 'Kraken',
      description:
          'Privacy-focused cryptocurrency. Untraceable transactions, fungible.',
    ),
    Instrument(
      symbol: 'PEPE/USD',
      name: 'Pepe Coin',
      type: InstrumentType.crypto,
      sector: Sector.technology,
      market: MarketRegime.crypto,
      basePrice: 0.00000198,
      volatility: 1.45, // Extremely volatile
      exchange: 'Binance',
      description:
          'Viral meme coin. Teaching example of extreme volatility and speculation risk.',
    ),
  ];
  static const List<Instrument> indiaIndices = [
    Instrument(
      symbol: 'NIFTY 50',
      name: 'NIFTY 50',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.india,
      basePrice: 25693.70,
      volatility: 0.12,
      description: 'NSE benchmark index of top 50 large-cap stocks by market capitalization.',
      exchange: 'NSE',
    ),
    Instrument(
      symbol: 'SENSEX',
      name: 'S&P BSE SENSEX',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.india,
      basePrice: 83580.40,
      volatility: 0.12,
      description: 'BSE benchmark index of 30 established and financially sound companies.',
      exchange: 'BSE',
    ),
    Instrument(
      symbol: 'BANK NIFTY',
      name: 'Nifty Bank',
      type: InstrumentType.marketIndex,
      sector: Sector.financialServices,
      market: MarketRegime.india,
      basePrice: 60120.70,
      volatility: 0.14,
      description: 'NSE banking sector index tracking the 12 most liquid banking stocks.',
      exchange: 'NSE',
    ),
  ];
  static const List<Instrument> usaIndices = [
    Instrument(
      symbol: 'S&P 500',
      name: 'S&P 500',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.usa,
      basePrice: 5850.25,
      volatility: 0.13,
      description: 'Benchmark index tracking 500 leading US publicly traded companies.',
      exchange: 'NYSE',
    ),
    Instrument(
      symbol: 'DOW JONES',
      name: 'Dow Jones Industrial Avg',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.usa,
      basePrice: 43250.60,
      volatility: 0.12,
      description: 'Price-weighted index of 30 prominent US blue-chip companies.',
      exchange: 'NYSE',
    ),
    Instrument(
      symbol: 'NASDAQ',
      name: 'NASDAQ Composite',
      type: InstrumentType.marketIndex,
      sector: Sector.technology,
      market: MarketRegime.usa,
      basePrice: 18720.40,
      volatility: 0.15,
      description: 'Technology-heavy composite index of all NASDAQ-listed stocks.',
      exchange: 'NASDAQ',
    ),
  ];
  static const List<Instrument> ukIndices = [
    Instrument(
      symbol: 'FTSE 100',
      name: 'FTSE 100',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.uk,
      basePrice: 7520.80,
      volatility: 0.11,
      description: 'Benchmark index of 100 largest UK-listed companies by market cap.',
      exchange: 'LSE',
    ),
    Instrument(
      symbol: 'FTSE 250',
      name: 'FTSE 250',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.uk,
      basePrice: 19800.45,
      volatility: 0.13,
      description: 'Mid-cap index of companies ranked 101st to 350th by market cap.',
      exchange: 'LSE',
    ),
  ];

  static const List<Instrument> cryptoIndices = [
    Instrument(
      symbol: 'TOTAL',
      name: 'Total Crypto Market Cap',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.crypto,
      basePrice: 1720000000000.0,
      volatility: 0.55,
      description: 'Combined market capitalization of all cryptocurrencies.',
      exchange: 'Aggregate',
    ),
    Instrument(
      symbol: 'BTC.D',
      name: 'Bitcoin Dominance',
      type: InstrumentType.marketIndex,
      sector: Sector.unknown,
      market: MarketRegime.crypto,
      basePrice: 52.4,
      volatility: 0.25,
      description: 'Bitcoin market cap as percentage of total crypto market cap.',
      exchange: 'Aggregate',
    ),
  ];

  static List<Instrument> getInstruments(MarketRegime market) {
    switch (market) {
      case MarketRegime.usa:
        return usaInstruments;
      case MarketRegime.india:
        return indiaInstruments;
      case MarketRegime.uk:
        return ukInstruments;
      case MarketRegime.crypto:
        return cryptoInstruments;
    }
  }

  static List<Instrument> getIndices(MarketRegime market) {
    switch (market) {
      case MarketRegime.usa:
        return usaIndices;
      case MarketRegime.india:
        return indiaIndices;
      case MarketRegime.uk:
        return ukIndices;
      case MarketRegime.crypto:
        return cryptoIndices;
    }
  }

  static Instrument? findInstrument(String symbol, MarketRegime market) {
    final instruments = getInstruments(market);
    try {
      return instruments.firstWhere((i) => i.symbol == symbol);
    } catch (_) {
      return null;
    }
  }

  static List<Instrument> get allInstruments => [
        ...usaInstruments,
        ...indiaInstruments,
        ...ukInstruments,
        ...cryptoInstruments,
      ];
}
