class OnboardingInfo {
  final String image;
  final String description;
  final String title;

  OnboardingInfo({
    required this.image,
    required this.description,
    required this.title,
  });
}

class OnboardingItems {
  final List<OnboardingInfo> items = [
    OnboardingInfo(
      image: 'assets/images/poetry.jpg',
      description:
          'Discover a world where words come alive. Join our community of passionate poets, share your thoughts, and immerse yourself in the beauty of poetry.',
      title: 'Welcome to Poets Haven',
    ),
    OnboardingInfo(
      image: 'assets/images/poetry.jpg',
      description:
          "Share your unique voice through poetry. Post your creations, get inspired by others, and let your words resonate with like-minded individuals.",
      title: 'Express Your Soul',
    ),
    OnboardingInfo(
      image: 'assets/images/poetry.jpg',
      description:
          'Build meaningful connections with fellow poets. Like, comment, and save the poems that move you, and grow your following as you inspire others.',
      title: 'Connect and Engage',
    ),
  ];
}
