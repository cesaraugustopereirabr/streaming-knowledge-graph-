// -------------------------------------------------------------------
// 1. CRIAÇÃO DE CONSTRAINTS E ÍNDICES (GARANTIA DE UNICIDADE E PERFORMANCE)
// -------------------------------------------------------------------

// Nodes de Conteúdo
CREATE CONSTRAINT unique_movie_id IF NOT EXISTS FOR (m:Movie) REQUIRE m.movieId IS UNIQUE;
CREATE CONSTRAINT unique_series_id IF NOT EXISTS FOR (s:Series) REQUIRE s.seriesId IS UNIQUE;

// Nodes de Pessoas
CREATE CONSTRAINT unique_user_id IF NOT EXISTS FOR (u:User) REQUIRE u.userId IS UNIQUE;
CREATE CONSTRAINT unique_actor_id IF NOT EXISTS FOR (a:Actor) REQUIRE a.actorId IS UNIQUE;
CREATE CONSTRAINT unique_director_id IF NOT EXISTS FOR (d:Director) REQUIRE d.directorId IS UNIQUE;

// Nodes de Categorias (Genre name é a chave natural)
CREATE CONSTRAINT unique_genre_name IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;

// -------------------------------------------------------------------
// 2. POPULAÇÃO DE NÓS (Entities)
// O uso de MERGE garante que os nós só sejam criados se não existirem.
// -------------------------------------------------------------------

// Gêneros
MERGE (:Genre {name: 'Ação'});
MERGE (:Genre {name: 'Ficção Científica'});
MERGE (:Genre {name: 'Drama'});
MERGE (:Genre {name: 'Comédia'});
MERGE (:Genre {name: 'Suspense'});
MERGE (:Genre {name: 'Fantasia'});

// Diretores
MERGE (:Director {directorId: 101, name: 'Ava DuVernay'});
MERGE (:Director {directorId: 102, name: 'Christopher Nolan'});
MERGE (:Director {directorId: 103, name: 'Greta Gerwig'});
MERGE (:Director {directorId: 104, name: 'Steven Spielberg'});

// Atores
MERGE (:Actor {actorId: 201, name: 'Tom Hanks'});
MERGE (:Actor {actorId: 202, name: 'Zendaya'});
MERGE (:Actor {actorId: 203, name: 'Leonardo DiCaprio'});
MERGE (:Actor {actorId: 204, name: 'Scarlett Johansson'});

// Usuários (10 Usuários)
MERGE (:User {userId: 301, username: 'neo_user_alpha', registrationDate: datetime('2024-01-10T10:00:00Z')});
MERGE (:User {userId: 302, username: 'graph_lover_beta', registrationDate: datetime('2024-02-15T12:30:00Z')});
MERGE (:User {userId: 303, username: 'cypher_fan_gamma', registrationDate: datetime('2024-03-20T15:00:00Z')});
MERGE (:User {userId: 304, username: 'data_explorer', registrationDate: datetime('2024-04-01T08:00:00Z')});
MERGE (:User {userId: 305, username: 'stream_addict', registrationDate: datetime('2024-05-05T18:00:00Z')});
MERGE (:User {userId: 306, username: 'movie_buff', registrationDate: datetime('2024-06-12T09:45:00Z')});
MERGE (:User {userId: 307, username: 'series_fan', registrationDate: datetime('2024-07-22T11:20:00Z')});
MERGE (:User {userId: 308, username: 'action_junkie', registrationDate: datetime('2024-08-01T14:00:00Z')});
MERGE (:User {userId: 309, username: 'drama_queen', registrationDate: datetime('2024-09-15T16:30:00Z')});
MERGE (:User {userId: 310, username: 'scifi_guy', registrationDate: datetime('2024-10-25T19:00:00Z')});

// Filmes (10 Filmes)
MERGE (:Movie {movieId: 401, title: 'Inception', releaseYear: 2010, duration: 148});
MERGE (:Movie {movieId: 402, title: 'Barbie', releaseYear: 2023, duration: 114});
MERGE (:Movie {movieId: 403, title: 'Forrest Gump', releaseYear: 1994, duration: 142});
MERGE (:Movie {movieId: 404, title: 'Black Panther', releaseYear: 2018, duration: 134});
MERGE (:Movie {movieId: 405, title: 'Oppenheimer', releaseYear: 2023, duration: 180});
MERGE (:Movie {movieId: 406, title: 'The Martian', releaseYear: 2015, duration: 144});
MERGE (:Movie {movieId: 407, title: 'Catch Me If You Can', releaseYear: 2002, duration: 141});
MERGE (:Movie {movieId: 408, title: 'Lost in Translation', releaseYear: 2003, duration: 101});
MERGE (:Movie {movieId: 409, title: 'Jaws', releaseYear: 1975, duration: 124});
MERGE (:Movie {movieId: 410, title: 'Selma', releaseYear: 2014, duration: 128});

// Séries (10 Séries)
MERGE (:Series {seriesId: 501, title: 'Ozark', startYear: 2017, endYear: 2022});
MERGE (:Series {seriesId: 502, title: 'Stranger Things', startYear: 2016, endYear: 0}); // 0 ou null para em andamento
MERGE (:Series {seriesId: 503, title: 'Succession', startYear: 2018, endYear: 2023});
MERGE (:Series {seriesId: 504, title: 'The Crown', startYear: 2016, endYear: 2023});
MERGE (:Series {seriesId: 505, title: 'Euphoria', startYear: 2019, endYear: 0});
MERGE (:Series {seriesId: 506, title: 'The Last of Us', startYear: 2023, endYear: 0});
MERGE (:Series {seriesId: 507, title: 'Chernobyl', startYear: 2019, endYear: 2019});
MERGE (:Series {seriesId: 508, title: 'The Office (US)', startYear: 2005, endYear: 2013});
MERGE (:Series {seriesId: 509, title: 'Friends', startYear: 1994, endYear: 2004});
MERGE (:Series {seriesId: 510, title: 'Breaking Bad', startYear: 2008, endYear: 2013});

// -------------------------------------------------------------------
// 3. POPULAÇÃO DE RELACIONAMENTOS (Edges)
// -------------------------------------------------------------------

// 3.1. Relações de Gênero (IN_GENRE)
MATCH (m:Movie {movieId: 401}), (g:Genre {name: 'Ficção Científica'}) MERGE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {movieId: 401}), (g:Genre {name: 'Ação'}) MERGE (m)-[:IN_GENRE]->(g);

MATCH (m:Movie {movieId: 402}), (g:Genre {name: 'Comédia'}) MERGE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {movieId: 402}), (g:Genre {name: 'Fantasia'}) MERGE (m)-[:IN_GENRE]->(g);

MATCH (m:Movie {movieId: 403}), (g:Genre {name: 'Drama'}) MERGE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {movieId: 405}), (g:Genre {name: 'Drama'}) MERGE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {movieId: 405}), (g:Genre {name: 'Suspense'}) MERGE (m)-[:IN_GENRE]->(g);

MATCH (s:Series {seriesId: 502}), (g:Genre {name: 'Ficção Científica'}) MERGE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {seriesId: 505}), (g:Genre {name: 'Drama'}) MERGE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {seriesId: 510}), (g:Genre {name: 'Drama'}) MERGE (s)-[:IN_GENRE]->(g);


// 3.2. Relações de Elenco e Direção (ACTED_IN, DIRECTED)

// Inception
MATCH (d:Director {directorId: 102}), (m:Movie {movieId: 401}) MERGE (d)-[:DIRECTED]->(m);
MATCH (a:Actor {actorId: 203}), (m:Movie {movieId: 401}) MERGE (a)-[:ACTED_IN]->(m);

// Oppenheimer
MATCH (d:Director {directorId: 102}), (m:Movie {movieId: 405}) MERGE (d)-[:DIRECTED]->(m);

// Selma
MATCH (d:Director {directorId: 101}), (m:Movie {movieId: 410}) MERGE (d)-[:DIRECTED]->(m);

// Catch Me If You Can
MATCH (a:Actor {actorId: 201}), (m:Movie {movieId: 407}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (d:Director {directorId: 104}), (m:Movie {movieId: 407}) MERGE (d)-[:DIRECTED]->(m);

// Lost in Translation
MATCH (a:Actor {actorId: 204}), (m:Movie {movieId: 408}) MERGE (a)-[:ACTED_IN]->(m);

// Euphoria
MATCH (a:Actor {actorId: 202}), (s:Series {seriesId: 505}) MERGE (a)-[:ACTED_IN]->(s);

// 3.3. Relações de Consumo (WATCHED) - Incluindo propriedade de `rating` e `watchedOn`
// Usuário 301 assiste a 3 conteúdos
MATCH (u:User {userId: 301}), (m:Movie {movieId: 401}) MERGE (u)-[:WATCHED {rating: 5, watchedOn: datetime('2024-11-01T20:00:00Z')}]->(m);
MATCH (u:User {userId: 301}), (m:Movie {movieId: 403}) MERGE (u)-[:WATCHED {rating: 4, watchedOn: datetime('2024-11-05T19:30:00Z')}]->(m);
MATCH (u:User {userId: 301}), (s:Series {seriesId: 502}) MERGE (u)-[:WATCHED {rating: 5, watchedOn: datetime('2024-11-10T21:00:00Z')}]->(s);

// Usuário 302 assiste a 2 conteúdos
MATCH (u:User {userId: 302}), (m:Movie {movieId: 402}) MERGE (u)-[:WATCHED {rating: 3, watchedOn: datetime('2024-11-02T18:00:00Z')}]->(m);
MATCH (u:User {userId: 302}), (s:Series {seriesId: 505}) MERGE (u)-[:WATCHED {rating: 4, watchedOn: datetime('2024-11-15T22:00:00Z')}]->(s);

// Usuário 303 assiste a 1 conteúdo
MATCH (u:User {userId: 303}), (m:Movie {movieId: 405}) MERGE (u)-[:WATCHED {rating: 5, watchedOn: datetime('2024-11-20T23:00:00Z')}]->(m);

// Usuário 304 assiste a 2 conteúdos
MATCH (u:User {userId: 304}), (s:Series {seriesId: 502}) MERGE (u)-[:WATCHED {rating: 4, watchedOn: datetime('2024-11-25T17:00:00Z')}]->(s);
MATCH (u:User {userId: 304}), (s:Series {seriesId: 510}) MERGE (u)-[:WATCHED {rating: 5, watchedOn: datetime('2024-11-28T20:00:00Z')}]->(s);

// Usuário 305 assiste a 2 conteúdos
MATCH (u:User {userId: 305}), (m:Movie {movieId: 407}) MERGE (u)-[:WATCHED {rating: 4, watchedOn: datetime('2024-12-01T19:00:00Z')}]->(m);
MATCH (u:User {userId: 305}), (m:Movie {movieId: 408}) MERGE (u)-[:WATCHED {rating: 3, watchedOn: datetime('2024-12-05T21:30:00Z')}]->(m);

// Usuário 306 assiste a 1 conteúdo
MATCH (u:User {userId: 306}), (m:Movie {movieId: 409}) MERGE (u)-[:WATCHED {rating: 4, watchedOn: datetime('2024-12-10T22:00:00Z')}]->(m);

// Usuário 307 assiste a 1 conteúdo
MATCH (u:User {userId: 307}), (s:Series {seriesId: 507}) MERGE (u)-[:WATCHED {rating: 5, watchedOn: datetime('2024-12-15T18:30:00Z')}]->(s);
