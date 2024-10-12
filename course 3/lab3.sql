CREATE TABLE docs03 (id SERIAL, doc TEXT, PRIMARY KEY(id));

INSERT INTO docs03 (doc) VALUES
('problem and develop a program to solve the problem'),
('In a sense you need two skills to be a programmer'),
('to know the vocabulary and the grammar You need to be able to spell'),
('the words in this new language properly and know how to construct'),
('wellformed sentences in this new language'),
('words and sentences to convey an idea to the reader There is a'),
('skill and art in constructing the story and skill in story writing'),
('is improved by doing some writing and getting some feedback In'),
('programming our program is the story and the problem you are'),
('trying to solve is the idea');

INSERT INTO docs03 (doc) SELECT 'Neon ' || generate_series(10000,20000);

CREATE INDEX array03 ON docs03 USING gin(string_to_array(lower(doc), ' ') array_ops);

SELECT id, doc FROM docs03 WHERE '{constructing}' <@ string_to_array(lower(doc), ' ');
EXPLAIN SELECT id, doc FROM docs03 WHERE '{constructing}' <@ string_to_array(lower(doc), ' ');