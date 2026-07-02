import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../../core/domain/instrument.dart';
import '../../../../../core/domain/market_data.dart';
import '../../../../../core/services/api_market_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class TechnicalsTab extends StatefulWidget {
  final Instrument instrument;

  const TechnicalsTab({super.key, required this.instrument});

  @override
  State<TechnicalsTab> createState() => _TechnicalsTabState();
}

class _TechnicalsTabState extends State<TechnicalsTab> {
  List<Candle>? _candles;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchCandles();
  }

  Future<void> _fetchCandles() async {
    try {
      final candles = await ApiMarketService().getHistory(
        widget.instrument.symbol,
        Timeframe.oneHour,
      );
      if (mounted) {
        setState(() {
          _candles = candles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  double calculateSMA(List<double> data, int period) {
    if (data.isEmpty) return 0.0;
    if (data.length < period) {
      return data.reduce((a, b) => a + b) / data.length;
    }
    final sublist = data.sublist(data.length - period);
    return sublist.reduce((a, b) => a + b) / period;
  }

  double calculateEMA(List<double> data, int period) {
    if (data.isEmpty) return 0.0;
    if (data.length < period) {
      return calculateSMA(data, data.length);
    }
    double k = 2 / (period + 1);
    double ema = calculateSMA(data.sublist(0, period), period);
    for (int i = period; i < data.length; i++) {
      ema = data[i] * k + ema * (1 - k);
    }
    return ema;
  }

  double calculateRSI(List<double> data, int period) {
    if (data.length < period + 1) return 50.0;

    List<double> gains = [];
    List<double> losses = [];

    for (int i = 1; i < data.length; i++) {
      double change = data[i] - data[i - 1];
      if (change > 0) {
        gains.add(change);
        losses.add(0.0);
      } else {
        gains.add(0.0);
        losses.add(change.abs());
      }
    }

    double avgGain = gains.sublist(0, period).reduce((a, b) => a + b) / period;
    double avgLoss = losses.sublist(0, period).reduce((a, b) => a + b) / period;

    for (int i = period; i < gains.length; i++) {
      avgGain = (avgGain * (period - 1) + gains[i]) / period;
      avgLoss = (avgLoss * (period - 1) + losses[i]) / period;
    }

    if (avgLoss == 0) return 100.0;
    double rs = avgGain / avgLoss;
    return 100.0 - (100.0 / (1.0 + rs));
  }

  Map<String, double> calculateMACD(List<double> data) {
    if (data.length < 26) return {'macd': 0.0, 'signal': 0.0};

    List<double> macdLine = [];
    for (int i = 25; i < data.length; i++) {
      double ema12 = calculateEMA(data.sublist(0, i + 1), 12);
      double ema26 = calculateEMA(data.sublist(0, i + 1), 26);
      macdLine.add(ema12 - ema26);
    }

    double macdVal = macdLine.last;
    double signalVal = calculateEMA(macdLine, 9);
    return {'macd': macdVal, 'signal': signalVal};
  }

  double calculateStochastic(
    List<double> closes,
    List<double> highs,
    List<double> lows,
    int period,
  ) {
    if (closes.length < period) return 50.0;

    double currentClose = closes.last;
    List<double> subHighs = highs.sublist(highs.length - period);
    List<double> subLows = lows.sublist(lows.length - period);

    double highestHigh = subHighs.reduce((a, b) => a > b ? a : b);
    double lowestLow = subLows.reduce((a, b) => a < b ? a : b);

    if (highestHigh == lowestLow) return 50.0;
    return ((currentClose - lowestLow) / (highestHigh - lowestLow)) * 100.0;
  }

  double calculateCCI(
    List<double> closes,
    List<double> highs,
    List<double> lows,
    int period,
  ) {
    if (closes.length < period) return 0.0;

    List<double> tp = [];
    for (int i = 0; i < closes.length; i++) {
      tp.add((highs[i] + lows[i] + closes[i]) / 3.0);
    }

    double smaTP = calculateSMA(tp, period);
    List<double> subTP = tp.sublist(tp.length - period);

    double meanDeviation = 0.0;
    for (double val in subTP) {
      meanDeviation += (val - smaTP).abs();
    }
    meanDeviation /= period;

    if (meanDeviation == 0) return 0.0;
    return (tp.last - smaTP) / (0.015 * meanDeviation);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 80.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_hasError || _candles == null || _candles!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Text(
            'Failed to load technical analysis data',
            style: AppTypography.body.copyWith(color: AppColors.textTertiary),
          ),
        ),
      );
    }

    final closes = _candles!.map((c) => c.close).toList();
    final highs = _candles!.map((c) => c.high).toList();
    final lows = _candles!.map((c) => c.low).toList();
    final currentPrice = closes.last;

    // Moving Averages calculations
    final sma5 = calculateSMA(closes, 5);
    final ema5 = calculateEMA(closes, 5);
    final sma10 = calculateSMA(closes, 10);
    final ema10 = calculateEMA(closes, 10);
    final sma20 = calculateSMA(closes, 20);
    final ema20 = calculateEMA(closes, 20);
    final sma50 = calculateSMA(closes, 50);
    final ema50 = calculateEMA(closes, 50);
    final sma100 = calculateSMA(closes, 100);
    final ema100 = calculateEMA(closes, 100);
    final sma200 = calculateSMA(closes, 200);
    final ema200 = calculateEMA(closes, 200);

    // Oscillators calculations
    final rsi = calculateRSI(closes, 14);
    final macd = calculateMACD(closes);
    final stoch = calculateStochastic(closes, highs, lows, 14);
    final cci = calculateCCI(closes, highs, lows, 14);

    // Pivot Points calculations
    final lastCandle = _candles!.length > 1 ? _candles![_candles!.length - 2] : _candles!.last;
    final h = lastCandle.high;
    final l = lastCandle.low;
    final c = lastCandle.close;

    final pivotPoint = (h + l + c) / 3.0;
    final r1 = 2 * pivotPoint - l;
    final s1 = 2 * pivotPoint - h;
    final r2 = pivotPoint + (h - l);
    final s2 = pivotPoint - (h - l);
    final r3 = h + 2 * (pivotPoint - l);
    final s3 = l - 2 * (h - pivotPoint);

    // Sum recommendations
    int bullishCount = 0;
    int bearishCount = 0;
    int neutralCount = 0;

    void addMaSignal(double price, double ma) {
      if (price > ma) {
        bullishCount++;
      } else {
        bearishCount++;
      }
    }

    addMaSignal(currentPrice, sma5);
    addMaSignal(currentPrice, ema5);
    addMaSignal(currentPrice, sma10);
    addMaSignal(currentPrice, ema10);
    addMaSignal(currentPrice, sma20);
    addMaSignal(currentPrice, ema20);
    addMaSignal(currentPrice, sma50);
    addMaSignal(currentPrice, ema50);
    addMaSignal(currentPrice, sma100);
    addMaSignal(currentPrice, ema100);
    addMaSignal(currentPrice, sma200);
    addMaSignal(currentPrice, ema200);

    String rsiAction = 'NEUTRAL';
    Color rsiColor = AppColors.textSecondary;
    if (rsi > 70) {
      rsiAction = 'SELL';
      rsiColor = AppColors.lossRed;
      bearishCount++;
    } else if (rsi < 30) {
      rsiAction = 'BUY';
      rsiColor = AppColors.profitGreen;
      bullishCount++;
    } else {
      neutralCount++;
    }

    String macdAction = 'NEUTRAL';
    Color macdColor = AppColors.textSecondary;
    if (macd['macd']! > macd['signal']!) {
      macdAction = 'BUY';
      macdColor = AppColors.profitGreen;
      bullishCount++;
    } else {
      macdAction = 'SELL';
      macdColor = AppColors.lossRed;
      bearishCount++;
    }

    String stochAction = 'NEUTRAL';
    Color stochColor = AppColors.textSecondary;
    if (stoch > 80) {
      stochAction = 'SELL';
      stochColor = AppColors.lossRed;
      bearishCount++;
    } else if (stoch < 20) {
      stochAction = 'BUY';
      stochColor = AppColors.profitGreen;
      bullishCount++;
    } else {
      neutralCount++;
    }

    String cciAction = 'NEUTRAL';
    Color cciColor = AppColors.textSecondary;
    if (cci > 100) {
      cciAction = 'SELL';
      cciColor = AppColors.lossRed;
      bearishCount++;
    } else if (cci < -100) {
      cciAction = 'BUY';
      cciColor = AppColors.profitGreen;
      bullishCount++;
    } else {
      neutralCount++;
    }

    String summaryText = 'NEUTRAL';
    Color summaryColor = AppColors.amber;
    if (bullishCount >= 10) {
      summaryText = 'STRONG BUY';
      summaryColor = AppColors.profitGreen;
    } else if (bullishCount >= 6) {
      summaryText = 'BUY';
      summaryColor = AppColors.profitGreen;
    } else if (bearishCount >= 10) {
      summaryText = 'STRONG SELL';
      summaryColor = AppColors.lossRed;
    } else if (bearishCount >= 6) {
      summaryText = 'SELL';
      summaryColor = AppColors.lossRed;
    }

    final totalIndicators = bullishCount + bearishCount + neutralCount;
    final ratio = totalIndicators > 0 ? (bullishCount / totalIndicators) : 0.5;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Gauge Widget
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Summary', style: AppTypography.h5),
                    const Icon(Icons.show_chart_rounded, color: AppColors.primary),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 240,
                      child: CustomPaint(
                        painter: _GaugePainter(ratio: ratio),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          summaryText,
                          style: AppTypography.h4.copyWith(
                            color: summaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Based on $totalIndicators Indicators',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIndicatorStat('Bullish', '$bullishCount', AppColors.profitGreen),
                    _buildIndicatorStat('Neutral', '$neutralCount', AppColors.textSecondary),
                    _buildIndicatorStat('Bearish', '$bearishCount', AppColors.lossRed),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Moving Averages Table
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Moving Averages', style: AppTypography.h5),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _buildTableRow('Period', 'SMA', 'EMA', isHeader: true),
                    _buildTableRow('5 Day', sma5.toStringAsFixed(2), ema5.toStringAsFixed(2)),
                    _buildTableRow('10 Day', sma10.toStringAsFixed(2), ema10.toStringAsFixed(2)),
                    _buildTableRow('20 Day', sma20.toStringAsFixed(2), ema20.toStringAsFixed(2)),
                    _buildTableRow('50 Day', sma50.toStringAsFixed(2), ema50.toStringAsFixed(2)),
                    _buildTableRow('100 Day', sma100.toStringAsFixed(2), ema100.toStringAsFixed(2)),
                    _buildTableRow('200 Day', sma200.toStringAsFixed(2), ema200.toStringAsFixed(2), isLast: true),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Oscillators Table
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Oscillators', style: AppTypography.h5),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _buildTableRow('Name', 'Value', 'Action', isHeader: true),
                    _buildTableRow('RSI (14)', rsi.toStringAsFixed(1), rsiAction, actionColor: rsiColor),
                    _buildTableRow('MACD (12, 26)', macd['macd']!.toStringAsFixed(2), macdAction, actionColor: macdColor),
                    _buildTableRow('Stochastic (14)', stoch.toStringAsFixed(1), stochAction, actionColor: stochColor),
                    _buildTableRow('CCI (14)', cci.toStringAsFixed(1), cciAction, actionColor: cciColor, isLast: true),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Pivot Points Table
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pivot Points (Classic)', style: AppTypography.h5),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _buildTableRow('Level', 'Value', '', isHeader: true),
                    _buildTableRow('Resistance 3', r3.toStringAsFixed(2), ''),
                    _buildTableRow('Resistance 2', r2.toStringAsFixed(2), ''),
                    _buildTableRow('Resistance 1', r1.toStringAsFixed(2), ''),
                    _buildTableRow('Pivot Point', pivotPoint.toStringAsFixed(2), ''),
                    _buildTableRow('Support 1', s1.toStringAsFixed(2), ''),
                    _buildTableRow('Support 2', s2.toStringAsFixed(2), ''),
                    _buildTableRow('Support 3', s3.toStringAsFixed(2), '', isLast: true),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildIndicatorStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h3.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildTableRow(
    String col1,
    String col2,
    String col3, {
    bool isHeader = false,
    bool isLast = false,
    Color? actionColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: AppColors.border)),
        color: isHeader ? AppColors.backgroundPrimary.withValues(alpha: 0.5) : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              col1,
              style: isHeader
                  ? AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)
                  : AppTypography.bodySmall,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              col2,
              style: isHeader
                  ? AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)
                  : AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              col3,
              style: isHeader
                  ? AppTypography.labelSmall.copyWith(color: AppColors.textTertiary)
                  : AppTypography.bodySmall.copyWith(
                      color: actionColor ?? AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double ratio;

  _GaugePainter({required this.ratio});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    // Draw background track (semi-circle)
    paint.color = AppColors.border;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      paint,
    );

    // Draw active track
    paint.color = ratio >= 0.6
        ? AppColors.profitGreen
        : (ratio <= 0.4 ? AppColors.lossRed : AppColors.amber);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi * ratio,
      false,
      paint,
    );

    // Draw Needle
    final needlePaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.fill;

    final needleAngle = pi + pi * ratio;
    final needleLength = radius - 20;

    canvas.drawLine(
      center,
      Offset(
        center.dx + cos(needleAngle) * needleLength,
        center.dy + sin(needleAngle) * needleLength,
      ),
      Paint()
        ..color = AppColors.textPrimary
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );

    // Center dot
    canvas.drawCircle(center, 8, needlePaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.ratio != ratio;
  }
}
