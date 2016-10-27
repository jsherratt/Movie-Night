# Movie-Night
An iPhone app to help two people "agree" on what movie to watch

For this project you will be building an app to help two people “agree” on what movie to watch. To be clear, both users will be interacting with the same device, simply by handing it back and forth. Your app will access The Movie Database (https://www.themoviedb.org) using an API key you will need to request as one of your first steps. This API is not completely open, like the Star Wars API used for project 5, which did not require registration or a key.

While you must use the API specified above, we encourage you to contemplate and experiment with the best way to get two people to choose a movie. This will mean exploring the API documentation (two links below). As you may discover it is often easier to imagine ways you would like to fetch, parse and match data, than it is to implement them. We suggest that you begin with a two or three step matching process before embarking on anything more complex.

For instance, you may decide to first query for the most popular actors then have each user take a turn selecting 5 actors they like - this could be done using a TableView or Picker. Then, using those selections, query for movies with combinations of those actors and display a subsequent list in a TableView which the users can again select from, which would lead to final movie being chosen. Alternatively, you could have users each select a fews genres and then bring up a list of recent movies in the overlapping genres.

We welcome your creativity in deciding how the users choose, though the purpose of this project is to demonstrate proficiency with TableViews, API calls and data modeling not creating complex matching algorithms. That said, provided your app already shows proficiency with the tools mentioned above feel free to implement (or try) more creative, elegant or complex matching.

In the project files, you’ll see that we have provided some sample mockups, image assets and icons. You can feel free to use these, or find or create your own design elements, so long as it provides a good user experience.

Please note, this project is more open-ended than projects 1-5. Some instructions are intentionally vague in order to allow you to experiment and give the app your own personal touch. There are many valid ways you could approach this problem.
