# Course Content Structure

## Folder Organization

```
lib/features/learning/data/courses/
├── foundations_of_trading.dart          # Main course definition
└── foundations_of_trading/              # Course-specific folder
    ├── chapter1_content.dart            # Chapter 1: What is Trading & Investing
    ├── chapter2_content.dart            # Chapter 2: How Financial Markets Work (TODO)
    ├── chapter3_content.dart            # Chapter 3: Market Participants (TODO)
    ├── chapter4_content.dart            # Chapter 4: Mastering Order Types (TODO)
    ├── chapter5_content.dart            # Chapter 5: Trading Terminology (TODO)
    └── chapter6_content.dart            # Chapter 6: Before You Start Trading (TODO)
```

## Naming Convention

### ✅ Use "Chapter" (not "Module")
- **IDs**: `chapter-1`, `chapter-2`, etc.
- **Files**: `chapter1_content.dart`, `chapter2_content.dart`, etc.
- **Classes**: `Chapter1Content`, `Chapter2Content`, etc.
- **Methods**: `getTradingVsInvestingContent()`, `getWhyPeopleTradeContent()`, etc.

### Course Structure
Each course has:
1. **Main course file** (e.g., `foundations_of_trading.dart`)
   - Defines course metadata
   - Lists all chapters
   - Calculates totals (lessons, minutes, XP)

2. **Course folder** (e.g., `foundations_of_trading/`)
   - Contains chapter content files
   - One file per chapter
   - Each file has content for all lessons in that chapter

## Chapter Content Format

Each chapter content file should follow this structure:

```dart
/// Chapter X: [Chapter Title]
/// Complete interactive content for all lessons in this chapter
class ChapterXContent {
  // Lesson 1
  static Map<String, dynamic> getLessonOneName() {
    return {
      'slides': [
        {
          'type': 'story',
          'title': 'Story Title',
          'emoji': '👥',
          'content': '''Story content here...''',
        },
        {
          'type': 'concept',
          'title': 'Concept Title',
          'emoji': '📊',
          'content': '''Concept explanation...''',
          'keyPoints': [
            'Point 1',
            'Point 2',
          ],
        },
        {
          'type': 'quiz',
          'title': 'Quiz Title',
          'question': 'Question text?',
          'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          'correctIndex': 1,
          'explanation': 'Why this is correct...',
        },
        {
          'type': 'scenario',
          'title': 'Scenario Title',
          'situation': 'Scenario description...',
          'choices': [
            {
              'text': 'Choice 1',
              'isCorrect': true,
              'feedback': '✅ Correct feedback',
            },
            {
              'text': 'Choice 2',
              'isCorrect': false,
              'feedback': '❌ Incorrect feedback',
            },
          ],
        },
        {
          'type': 'interactive',
          'title': 'Interactive Title',
          'emoji': '🪄',
          'content': '''Interactive content with calculations, examples, etc.''',
        },
        {
          'type': 'summary',
          'title': 'Key Takeaways',
          'keyPoints': [
            'Takeaway 1',
            'Takeaway 2',
          ],
        },
      ],
    };
  }

  // Lesson 2
  static Map<String, dynamic> getLessonTwoName() {
    // Same structure...
  }
}
```

## Slide Types

### 1. **Story** (`type: 'story'`)
- Real-world narrative
- Relatable characters
- Emotional journey
- Concrete outcomes

### 2. **Concept** (`type: 'concept'`)
- Educational content
- Key points list
- Clear explanations
- Examples

### 3. **Quiz** (`type: 'quiz'`)
- Multiple choice question
- 4 options
- Correct index (0-3)
- Explanation

### 4. **Scenario** (`type: 'scenario'`)
- Real-world situation
- Multiple choices
- Feedback for each choice
- Can have multiple correct answers

### 5. **Interactive** (`type: 'interactive'`)
- Calculations
- Comparisons
- Examples with numbers
- Visual explanations

### 6. **Summary** (`type: 'summary'`)
- Key takeaways list
- Lesson recap
- Next steps

### 7. **Intro** (`type: 'intro'`)
- Lesson introduction
- Set expectations
- Overview

## Content Guidelines

### ✅ DO:
- Use Indian context (₹, Indian names, NSE/BSE)
- Tell stories with real characters
- Use concrete numbers and outcomes
- Be honest about risks (90% failure rate)
- Include emotional elements (fear, greed, FOMO)
- Make it interactive (quizzes, scenarios)
- Provide immediate feedback
- Celebrate learning milestones

### ❌ DON'T:
- Use generic examples
- Sugarcoat the truth
- Make unrealistic promises
- Use jargon without explanation
- Create passive content
- Skip the "why" behind concepts

## Example: Chapter 1 (Complete)

**Chapter 1: What is Trading & Investing**
- ✅ Lesson 1: Trading vs Investing (12 min)
  - Story: Raj vs Priya
  - Concept: Core differences
  - Quiz: Understanding check
  - Scenario: Hot tip decision
  - Interactive: Compound interest
  - Summary: 6 takeaways

- ✅ Lesson 2: Why People Trade & Fail (10 min)
  - Story: Amit's journey
  - Concept: 7 reasons for failure
  - Quiz: Success rate reality
  - Scenario: Revenge trading
  - Interactive: Real cost calculation
  - Summary: 7 truths

- ✅ Lesson 3: Reality Check Quiz (8 min)
  - Intro: Set expectations
  - 5 comprehensive quizzes
  - Summary: Completion celebration

## Next Steps

To add a new chapter:

1. Create `chapterX_content.dart` in the course folder
2. Define `ChapterXContent` class
3. Add static methods for each lesson
4. Follow the slide structure format
5. Use proper naming conventions
6. Include all slide types for variety
7. Make it engaging and interactive

## Integration with Lesson Screen

The `LessonScreen` will:
1. Receive a `Lesson` object
2. Load content from the appropriate chapter file
3. Parse the slide data
4. Render the appropriate widgets
5. Handle user interactions
6. Track progress and award XP

---

**Current Status:**
- ✅ Folder structure created
- ✅ Naming convention established
- ✅ Chapter 1 content complete (3 lessons)
- ⏳ Chapters 2-6 pending (17 lessons)
- ⏳ Lesson screen integration pending
