const termsAndPolicy =
    "By continuing, you agree to our\nTerms of service  Privacy Policy  Content Policy";

const otpScreenScript = "We've sent you a code to verify your \n phone number";

const loadingTextList = [
  "One breath at a time.",
  "Mood? Let’s find out!",
  "Feel. Breathe. Begin again",
  "Smiles take a second",
  "Peace is loading gently",
  "You’re in safe hands",
  "Soft start Big shift",
  "This moment is yours",
  "Calm is setting in",
  "Energy finding its flow",
  "Just feelings, no filters",
  "Let it be light",
  "Emotions have entered chat",
  "A little peace ahead",
  "Hearts loading with care"
];

const logOutSheetTitle = "Log Out of Mentaura ?";
const logOutSheetSubTitle =
    "Don’t worry, your journey is safe. Return anytime \nwhen you're ready to continue.";

const moodDeleteSheetTitle = "Delete Mood Entry?";
const moodDeleteSheetSubtitle =
    "This action will remove the mood from your history. Are you sure you want to continue?";

const geminiMessage =
    "Analyze the following message: Yesterday my friend was died in a accident, i cant sleep after that incident, idont knwo how to igone it. Identify the primary emotion expressed from one of these: happy, surprised, neutral, sad, depressed, angry. Provide the emotion, a confidence score between 0 and 1, and a short friendly suggested reply with a title (e.g., Ohh... I think you're feeling sad). Also give different and unique activities based on detected emotion type, (eg, if detected emotion is depressed, activity title is like Dont stay alone, explantion is like Dont stay at room lonely spend time with your friends and share your emotions to you friend.) Return only a JSON with the keys: emotion, confidence, suggestedReplyTitle, and suggestedReply, activityTitle, explanation";

const geminiApiMessageTwo =
    "Analyze: 'Yesterday my friend died in an accident, I can't sleep since then. I don't know how to ignore it.' Detect one emotion: happy, surprised, neutral, sad, depressed, angry. Return JSON with: emotion, confidence (0–1), suggestedReplyTitle (e.g., 'Ohh... I think you're feeling sad'), suggestedReply, activityTitle (e.g., 'Don't stay alone'), and explanation (e.g., 'Spend time with friends and share your emotions.'). Make all outputs friendly and emotion-appropriate.";

final RegExp emojiRegex = RegExp(
  r'['
  r'\u{1F600}-\u{1F64F}' // Emoticons
  r'\u{1F300}-\u{1F5FF}' // Misc Symbols and Pictographs
  r'\u{1F680}-\u{1F6FF}' // Transport and Map Symbols
  r'\u{1F700}-\u{1F77F}' // Alchemical Symbols
  r'\u{1F780}-\u{1F7FF}' // Geometric Shapes Extended
  r'\u{1F800}-\u{1F8FF}' // Supplemental Arrows-C
  r'\u{1F900}-\u{1F9FF}' // Supplemental Symbols and Pictographs
  r'\u{1FA00}-\u{1FA6F}' // Chess Symbols
  r'\u{1FA70}-\u{1FAFF}' // Symbols and Pictographs Extended-A
  r'\u{2300}-\u{23FF}' // Misc Technical
  r'\u{2600}-\u{26FF}' // Misc Symbols
  r'\u{2700}-\u{27BF}' // Dingbats
  r'\u{FE00}-\u{FE0F}' // Variation Selectors
  r'\u{1F1E6}-\u{1F1FF}' // Regional Indicator Symbols (flags)
  r']',
  unicode: true,
);

const List<Map<String, String>> fallbackQuotes = [
  {
    "quote": "Believe you can and you're halfway there.",
    "author": "Theodore Roosevelt"
  },
  {
    "quote": "The only way to do great work is to love what you do.",
    "author": "Steve Jobs"
  },
  {
    "quote": "You miss 100% of the shots you don’t take.",
    "author": "Wayne Gretzky"
  },
  {
    "quote":
        "Success is not final, failure is not fatal: It is the courage to continue that counts.",
    "author": "Winston Churchill"
  },
  {
    "quote": "Don’t watch the clock; do what it does. Keep going.",
    "author": "Sam Levenson"
  },
  {"quote": "Dream big and dare to fail.", "author": "Norman Vaughan"},
  {
    "quote": "It always seems impossible until it’s done.",
    "author": "Nelson Mandela"
  },
  {
    "quote": "Act as if what you do makes a difference. It does.",
    "author": "William James"
  },
  {
    "quote":
        "Happiness is not something ready made. It comes from your own actions.",
    "author": "Dalai Lama"
  },
  {
    "quote": "Everything you’ve ever wanted is on the other side of fear.",
    "author": "George Addair"
  }
];

// final Map<String, String> aiRecommendedActivities = {
//   "Mindful Breathing": "Take 2 minutes to focus on your breath and relax.",
//   "Listen to Music": "Play a calming song or your favorite upbeat tune.",
//   "Take a Short Walk": "Go for a 10-minute walk to refresh your mind.",
//   "Write Your Thoughts": "Journal one sentence about how you're feeling now.",
//   "Have a Warm Drink": "Enjoy a cup of tea or coffee slowly and mindfully.",
//   "Step Outside": "Get some fresh air and notice your surroundings.",
//   "Digital Detox": "Stay off your phone for the next 15 minutes.",
//   "Smile Break": "Look in the mirror and smile at yourself for 5 seconds.",
//   "Doodle Something": "Grab a pen and draw whatever comes to mind.",
//   "Send a Kind Message": "Text a friend or loved one something nice.",
// };

final List<Map<String, String>> aiRecommendedActivities = [
  {
    "title": "Mindful Breathing",
    "subtitle": "Take 2 minutes to focus on your breath and relax."
  },
  {
    "title": "Listen to Music",
    "subtitle": "Play a calming song or your favorite upbeat tune."
  },
  {
    "title": "Take a Short Walk",
    "subtitle": "Go for a 10-minute walk to refresh your mind."
  },
  {
    "title": "Write Your Thoughts",
    "subtitle": "Journal one sentence about how you're feeling now."
  },
  {
    "title": "Have a Warm Drink",
    "subtitle": "Enjoy a cup of tea or coffee slowly and mindfully."
  },
  {
    "title": "Step Outside",
    "subtitle": "Get some fresh air and notice your surroundings."
  },
  {
    "title": "Digital Detox",
    "subtitle": "Stay off your phone for the next 15 minutes."
  },
  {
    "title": "Smile Break",
    "subtitle": "Look in the mirror and smile at yourself for 5 seconds."
  },
  {
    "title": "Doodle Something",
    "subtitle": "Grab a pen and draw whatever comes to mind."
  },
  {
    "title": "Send a Kind Message",
    "subtitle": "Text a friend or loved one something nice."
  },
];
