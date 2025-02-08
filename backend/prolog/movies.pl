:- dynamic movie/7.

% Define movie facts
movie('Inception', 'Sci-Fi', 'English', ['Leonardo DiCaprio', 'Joseph Gordon-Levitt'], 2010, [8.8], 'PG-13').
movie('The Matrix', 'Sci-Fi', 'English', ['Keanu Reeves', 'Laurence Fishburne'], 1999, [8.7], 'R').
movie('The Shawshank Redemption', 'Drama', 'English', ['Tim Robbins', 'Morgan Freeman'], 1994, [9.3], 'R').
movie('The Godfather', 'Crime', 'English', ['Marlon Brando', 'Al Pacino'], 1972, [9.2], 'R').
movie('Pulp Fiction', 'Crime', 'English', ['John Travolta', 'Samuel L. Jackson'], 1994, [8.9], 'R').
movie('Fight Club', 'Drama', 'English', ['Brad Pitt', 'Edward Norton'], 1999, [8.8], 'R').
movie('Forrest Gump', 'Drama', 'English', ['Tom Hanks', 'Robin Wright'], 1994, [8.8], 'PG-13').
movie('The Dark Knight', 'Action', 'English', ['Christian Bale', 'Heath Ledger'], 2008, [9.0], 'PG-13').
movie('The Lord of the Rings: The Return of the King', 'Fantasy', 'English', ['Elijah Wood', 'Viggo Mortensen'], 2003, [8.9], 'PG-13').
movie('Schindler\'s List', 'Biography', 'English', ['Liam Neeson', 'Ralph Fiennes'], 1993, [8.9], 'R').
movie('The Silence of the Lambs', 'Thriller', 'English', ['Jodie Foster', 'Anthony Hopkins'], 1991, [8.6], 'R').
movie('Se7en', 'Crime', 'English', ['Brad Pitt', 'Morgan Freeman'], 1995, [8.6], 'R').
movie('The Green Mile', 'Drama', 'English', ['Tom Hanks', 'Michael Clarke Duncan'], 1999, [8.6], 'R').
movie('Life Is Beautiful', 'Drama', 'Italian', ['Roberto Benigni', 'Nicoletta Braschi'], 1997, [8.6], 'PG-13').
movie('The Pianist', 'Biography', 'English', ['Adrien Brody', 'Thomas Kretschmann'], 2002, [8.5], 'R').
movie('The Departed', 'Crime', 'English', ['Leonardo DiCaprio', 'Matt Damon'], 2006, [8.5], 'R').
movie('Gladiator', 'Action', 'English', ['Russell Crowe', 'Joaquin Phoenix'], 2000, [8.5], 'R').
movie('The Intouchables', 'Biography', 'French', ['François Cluzet', 'Omar Sy'], 2011, [8.5], 'R').
movie('The Prestige', 'Drama', 'English', ['Christian Bale', 'Hugh Jackman'], 2006, [8.5], 'PG-13').
movie('The Lion King', 'Animation', 'English', ['Matthew Broderick', 'Jeremy Irons'], 1994, [8.5], 'G').

% Define recommendation rules
recommend_movie(Genre, Language, Actors, ReleaseYear, MinRating, AgeRating, Movie) :-
    movie(Title, Genre, Language, MovieActors, MovieReleaseYear, Ratings, MovieAgeRating),
    subset(Actors, MovieActors),
    MovieReleaseYear =< ReleaseYear,
    member(Rating, Ratings),
    Rating >= MinRating,
    MovieAgeRating = AgeRating,
    Movie = movie(Title, Genre, Language, MovieActors, MovieReleaseYear, Ratings, MovieAgeRating).

% Helper predicate to check if a list is a subset of another list
subset([], _).
subset([H|T], List) :-
    member(H, List),
    subset(T, List).
