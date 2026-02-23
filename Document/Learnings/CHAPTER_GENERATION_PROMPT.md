# Chapter Content Generation Prompt Template

Use this prompt to generate complete, interactive chapter content for any course in the FinlearnPro learning app.

---

## 📋 PROMPT TEMPLATE

```
I need you to create a complete chapter for my financial learning app. Generate expert-level educational content with psychological engagement and interactive elements.

## COURSE DETAILS
- **Course Name**: [e.g., "Foundations of Trading", "Options Trading Mastery", "Technical Analysis"]
- **Chapter Number**: [e.g., Chapter 2, Chapter 3]
- **Chapter Title**: [e.g., "How Markets Work", "Understanding Chart Patterns"]
- **Target Audience**: [Beginner/Intermediate/Advanced]
- **Learning Objectives**: [List 3-5 key things students should learn]

## CONTENT REQUIREMENTS

### 1. Research & Expertise
- Research the topic using authoritative online sources (Investopedia, educational finance sites, expert blogs)
- Provide expert-level teaching while keeping explanations simple and relatable
- Use real-world examples from Indian markets (NSE, BSE, Indian stocks) where applicable
- Include current market context and practical scenarios

### 2. Chapter Structure
Create **3-5 lessons** per chapter. Each lesson should have **5-10 slides** with varied content types.

**Available Slide Types:**
- `intro` - Sets expectations, hooks the learner
- `story` - Real-world narrative with relatable characters (use Indian names, ₹ currency)
- `concept` - Core educational content with **bold** key terms
- `quiz` - Single-choice question with explanation
- `scenario` - Multiple-choice decision-making with feedback for each choice
- `interactive` - Calculations, comparisons, or visual demonstrations
- `summary` - Key takeaways recap

**Important**: Each lesson should have a UNIQUE structure. Don't follow the same pattern:
- Some lessons can be story-heavy (3-4 stories)
- Some can be concept-heavy (multiple concept slides)
- Some can have more quizzes/scenarios
- Vary the flow to keep engagement high

### 3. Slide Timing & Attention Span

**CRITICAL: Keep slides concise to maintain attention!**

**Target Reading Time Per Slide:**
- **Intro**: 20-30 seconds (2-3 sentences max)
- **Story**: 60-90 seconds (250-350 words)
- **Concept**: 45-75 seconds (200-300 words)
- **Quiz**: 30-45 seconds (question + 4 options)
- **Scenario**: 45-60 seconds (situation + 3-4 choices)
- **Interactive**: 60-90 seconds (calculations/comparisons)
- **Summary**: 30-45 seconds (5-6 bullet points)

**Total Lesson Time:** 8-15 minutes (5-10 slides)

**Conciseness Rules:**
- ✅ **DO**: Use bullet points, short paragraphs (2-3 lines max)
- ✅ **DO**: Break long concepts into multiple slides
- ✅ **DO**: Use **bold** to highlight key terms for scanning
- ❌ **DON'T**: Write walls of text (max 350 words per slide)
- ❌ **DON'T**: Explain everything in one slide
- ❌ **DON'T**: Use complex sentences or jargon without explanation

**Attention Retention Strategy:**
- First 3 slides: Hook with story/emotion (build curiosity)
- Middle slides: Deliver core learning (concepts/interactive)
- Last 2 slides: Reinforce with quiz/summary (test + reward)

### 4. Content Formatting Rules

**Story Slides:**
```
'type': 'story',
'title': 'Engaging Title',
'emoji': '👥',  // Choose relevant emoji
'content': '''
Brief introduction to set the scene.

**Character Name's Approach:**
"Quote from character explaining their thinking"

Action points:
• Bullet point 1
• Bullet point 2
• Bullet point 3

**Outcome:**
What happened as a result.

**Lesson:**
What we learn from this.
''',
```

**Concept Slides:**
```
'type': 'concept',
'title': 'Clear Concept Title',
'emoji': '📊',
'content': '''
**KEY TERM** is the definition or explanation.

**Attribute 1:** Description
**Attribute 2:** Description
**Attribute 3:** Description

---

**ANOTHER KEY TERM** with its explanation.

**More attributes...**

---

**Key Insight:** Main takeaway or wisdom.
''',
'keyPoints': [
  'Concise takeaway 1',
  'Concise takeaway 2',
  'Concise takeaway 3',
  'Concise takeaway 4',
  'Concise takeaway 5',
],
```

**Quiz Slides:**
```
'type': 'quiz',
'title': 'Quick Check',
'question': 'Specific, scenario-based question?',
'options': ['Option A', 'Option B', 'Option C', 'Option D'],
'correctIndex': 1,  // 0-based index
'explanation': 'Detailed explanation of why this is correct and others are wrong.',
```

**Scenario Slides:**
```
'type': 'scenario',
'title': 'What Would You Do?',
'situation': 'Realistic scenario description with specific details',
'choices': [
  {
    'text': 'Choice 1',
    'isCorrect': false,
    'feedback': '❌ Why this is wrong and what could happen',
  },
  {
    'text': 'Choice 2',
    'isCorrect': true,
    'feedback': '✅ Why this is right and what makes it smart',
  },
  // Can have multiple correct answers
],
```

**Interactive Slides:**
```
'type': 'interactive',
'title': 'Engaging Title',
'emoji': '🪄',
'content': '''
Setup or context.

**Comparison A:**
• Data point 1
• Data point 2
• Result: X

**Comparison B:**
• Data point 1
• Data point 2
• Result: Y

**The Difference:**
Explanation of why the difference matters.

**Key Lessons:**
1. Lesson 1
2. Lesson 2
3. Lesson 3
''',
```

**Summary Slides:**
```
'type': 'summary',
'title': 'Key Takeaways',
'keyPoints': [
  'Complete sentence summarizing main point 1',
  'Complete sentence summarizing main point 2',
  'Complete sentence summarizing main point 3',
  'Complete sentence summarizing main point 4',
  'Complete sentence summarizing main point 5',
],
```

### 5. Writing Style Guidelines

**Stories:**
- Use Indian names (Raj, Priya, Amit, Sneha, etc.)
- Use ₹ (Rupees) for all monetary values
- Make characters relatable (age 25-35, working professionals)
- Include emotional elements (stress, excitement, regret, success)
- Show clear before/after outcomes
- End with a lesson or question
- **Keep to 250-350 words** (60-90 second read time)
- Use short paragraphs (2-3 lines) for easy scanning

**Concepts:**
- Use `**BOLD**` for key terms that should stand out
- Break complex ideas into bullet points (max 6-8 points)
- Use analogies and metaphors for clarity
- Include specific numbers and data when relevant
- Add "Key Insight" sections for wisdom
- **Keep to 200-300 words** (45-75 second read time)
- If concept is complex, split into 2 slides instead of 1 long slide

**Quizzes:**
- Make questions scenario-based, not just definitions
- Include realistic numbers and situations
- Explanations should teach, not just confirm

**Scenarios:**
- Present realistic dilemmas learners will face
- Allow multiple correct answers when appropriate
- Feedback should be educational, not judgmental
- Use ✅ for correct, ❌ for incorrect

### 6. Psychological Engagement

**Hook Early:**
- Start each lesson with an intro slide that creates curiosity
- Use questions, surprising facts, or relatable problems

**Vary Pacing:**
- Alternate between heavy content and light interactions
- Don't put 3 concept slides in a row
- Break up learning with quizzes and scenarios

**Emotional Connection:**
- Use stories that trigger emotions (fear of loss, hope for gain)
- Include relatable struggles and victories
- Make learners see themselves in the characters

**Reward Progress:**
- End lessons with clear summary of what was learned
- Acknowledge the effort ("You've now mastered...")
- Preview what's coming next

### 7. Technical Implementation

**File Structure:**
```dart
/// Chapter X: [Chapter Title]
/// Complete interactive content for all lessons in this chapter
class ChapterXContent {
  // Lesson 1: [Lesson Title]
  static Map<String, dynamic> getLesson1Content() {
    return {
      'slides': [
        // All slides here
      ],
    };
  }
  
  // Lesson 2: [Lesson Title]
  static Map<String, dynamic> getLesson2Content() {
    return {
      'slides': [
        // All slides here
      ],
    };
  }
  
  // ... more lessons
}
```

**Course Registration:**
Update the main course file to include:
```dart
Lesson(
  id: 'lesson-X-Y',
  title: '[Lesson Title]',
  description: '[One-line description]',
  contentType: ContentType.interactive,
  estimatedMinutes: [8-15],
  order: Y,
  xpReward: 50,
  keyTakeaways: [
    'Takeaway 1',
    'Takeaway 2',
    'Takeaway 3',
  ],
),
```

## OUTPUT FORMAT

Provide:
1. **Chapter Overview** (2-3 sentences about what this chapter covers)
2. **Complete Dart Code** for `chapterX_content.dart`
3. **Lesson Metadata** for updating the main course file
4. **Learning Outcomes** (5-6 bullet points)

## EXAMPLE REQUEST

"Create Chapter 2 for the Foundations of Trading course titled 'How Markets Work'. Target audience is beginners. Learning objectives: Understand stock exchanges, learn about market participants, grasp how orders are matched, and know about market timings."
```

---

## 🎯 USAGE INSTRUCTIONS

1. **Copy the template** above
2. **Fill in the COURSE DETAILS** section with your specific requirements
3. **Paste into a new chat** with an AI assistant
4. **Review and refine** the generated content
5. **Test in the app** to ensure proper formatting

## ✅ QUALITY CHECKLIST

Before finalizing generated content, verify:

- [ ] All slides have proper `type`, `title`, and content
- [ ] Stories use Indian context (names, ₹, relatable scenarios)
- [ ] Concepts have `**bold**` formatting for key terms
- [ ] Quizzes have correct `correctIndex` (0-based)
- [ ] Scenarios have at least 3 choices with varied feedback
- [ ] Summary has 5-6 complete sentence takeaways
- [ ] Each lesson has 5-10 slides (not too short, not too long)
- [ ] Lessons have varied structures (not all the same pattern)
- [ ] Content is expert-level but explained simply
- [ ] Emojis are relevant and engaging
- [ ] No grammatical errors or typos
- [ ] Each slide is concise (under 350 words)
- [ ] Stories are 250-350 words, concepts are 200-300 words
- [ ] Total lesson time is 8-15 minutes

---

## 📚 REFERENCE: Chapter 1 Structure

**Lesson 1: Trading vs Investing** (7 slides)
- Intro → Story → Concept → Quiz → Scenario → Interactive → Summary

**Lesson 2: Why People Trade & Fail** (8 slides)  
- Intro → Story → Concept → Story → Quiz → Scenario → Interactive → Summary

**Lesson 3: Reality Check Quiz** (5 slides)
- Intro → Quiz → Quiz → Quiz → Summary

**Key Insight**: Each lesson has a DIFFERENT structure and flow!

---

## 💡 PRO TIPS

1. **Research First**: Spend some time reading authoritative sources before generating
2. **Use Real Data**: Include actual statistics, market facts, and proven strategies
3. **Test Scenarios**: Make sure quiz answers and scenario choices make logical sense
4. **Cultural Context**: Always use Indian market examples (Nifty, Sensex, Indian stocks)
5. **Emotional Hooks**: Every story should make the reader feel something
6. **Vary Length**: Some lessons can be 5 slides, others can be 10 - keep it dynamic
7. **Progressive Difficulty**: Later lessons in a chapter can be slightly more advanced

---

**Last Updated**: February 2026  
**Compatible With**: FinlearnPro Learning System v1.0
