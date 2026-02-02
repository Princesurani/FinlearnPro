import 'package:flutter/material.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen> {
  int? _selectedOptionIndex;
  bool _isSubmitted = false;
  final int _correctOptionIndex =
      1; // "Short (Sell)" is correct for this scenario

  void _handleOptionSelect(int index) {
    if (_isSubmitted) return;
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _submitAnswer() {
    setState(() {
      _isSubmitted = true;
    });

    if (_selectedOptionIndex == _correctOptionIndex) {
      _showFeedbackBottomSheet(
        isCorrect: true,
        title: 'Excellent Analysis!',
        description:
            'You identified the Bearish Divergence correctly. Higher highs in price but lower highs in RSI often indicate a reversal.',
      );
    } else {
      _showFeedbackBottomSheet(
        isCorrect: false,
        title: 'Not quite.',
        description:
            'Look closely at the RSI indicator below the chart. Even though price is going up, momentum is fading (Bearish Divergence).',
      );
    }
  }

  void _showFeedbackBottomSheet({
    required bool isCorrect,
    required String title,
    required String description,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isCorrect ? Colors.green[100] : Colors.red[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCorrect ? Icons.check_rounded : Icons.close_rounded,
                color: isCorrect ? Colors.green[700] : Colors.red[700],
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                  Navigator.pop(context); // Close screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B4EF5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black87),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_fire_department_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text(
              'Daily Shield',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Scenario Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.currency_bitcoin,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BTC/USDT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '4H Timeframe',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Mock Chart Area
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FE),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Stack(
                      children: [
                        // Grid lines
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            5,
                            (index) =>
                                Divider(height: 1, color: Colors.grey[300]),
                          ),
                        ),
                        // Chart simulated Text acting as a visual description for now
                        // In real app, use FL_Chart or similar
                        Center(
                          child: Icon(
                            Icons.show_chart_rounded,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          right: 10,
                          child: Text(
                            'Price: \$29,450',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Scenario Analysis',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B4EF5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bitcoin is forming lower highs on the RSI indicator while price is making higher highs. The volume is steadily decreasing as price approaches resistance.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Question
            const Text(
              'What is the most probable next move?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Options
            _buildOptionCard(
              index: 0,
              title: 'Long (Buy)',
              subtitle: 'Price will break out upward',
              icon: Icons.trending_up,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            _buildOptionCard(
              index: 1,
              title: 'Short (Sell)',
              subtitle: 'Price will reject and drop',
              icon: Icons.trending_down,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            _buildOptionCard(
              index: 2,
              title: 'Wait / Neutral',
              subtitle: 'Wait for confirmation candle',
              icon: Icons.remove_circle_outline,
              color: Colors.grey,
            ),

            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedOptionIndex != null && !_isSubmitted
                    ? _submitAnswer
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B4EF5),
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  _isSubmitted ? 'Submitted' : 'Submit Prediction',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedOptionIndex != null
                        ? Colors.white
                        : Colors.grey[500],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final bool isSelected = _selectedOptionIndex == index;
    // Show correct/incorrect colors ONLY after submission
    Color borderColor = Colors.transparent;
    Color backgroundColor = Colors.white;

    if (_isSubmitted) {
      if (index == _correctOptionIndex) {
        borderColor = Colors.green;
        backgroundColor = Colors.green[50]!;
      } else if (isSelected && index != _correctOptionIndex) {
        borderColor = Colors.red;
        backgroundColor = Colors.red[50]!;
      }
    } else {
      if (isSelected) {
        borderColor = const Color(0xFF6B4EF5);
        backgroundColor = const Color(0xFFF0EDFF);
      }
    }

    return GestureDetector(
      onTap: () => _handleOptionSelect(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            if (!isSelected && !_isSubmitted)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (_isSubmitted && index == _correctOptionIndex)
              const Icon(Icons.check_circle, color: Colors.green),
            if (_isSubmitted && isSelected && index != _correctOptionIndex)
              const Icon(Icons.cancel, color: Colors.red),
            if (!_isSubmitted && isSelected)
              const Icon(Icons.radio_button_checked, color: Color(0xFF6B4EF5)),
            if (!_isSubmitted && !isSelected)
              Icon(Icons.radio_button_unchecked, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
