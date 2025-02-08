% Define some sample movies
movie('Inception', scifi, english, 2010, 25, 'Leonardo DiCaprio', 8.8).
movie('Interstellar', scifi, english, 2014, 25, 'Matthew McConaughey', 8.6).
movie('The Matrix', scifi, english, 1999, 25, 'Keanu Reeves', 8.7).
movie('Parasite', thriller, korean, 2019, 18, 'Song Kang-ho', 8.6).
movie('Spirited Away', animation, japanese, 2001, 10, 'Rumi Hiiragi', 8.6).

% Define the recommend/7 predicate
recommend(Genre, Language, Year, Age, Actor, Rating, Recommendations) :-
    findall(Movie, (
        movie(Movie, Genre, Language, Year, Age, Actor, MovieRating),
        MovieRating >= Rating
    ), Recommendations).