CREATE TABLE docs02 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE TABLE invert02 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs02(id) ON DELETE CASCADE
);

INSERT INTO docs02 (doc) VALUES
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

CREATE TABLE stop_words (word TEXT unique);

INSERT INTO stop_words (word) VALUES 
('i'), ('a'), ('about'), ('an'), ('are'), ('as'), ('at'), ('be'), 
('by'), ('com'), ('for'), ('from'), ('how'), ('in'), ('is'), ('it'), ('of'), 
('on'), ('or'), ('that'), ('the'), ('this'), ('to'), ('was'), ('what'), 
('when'), ('where'), ('who'), ('will'), ('with');

insert into invert02(doc_id, keyword) select distinct d.id, lower(s.keyword) as keyword from docs02 as d, unnest(string_to_array(d.doc, ' ')) s(keyword) where NOT lower(keyword) = any(select stop_words.word from stop_words); 

SELECT keyword, doc_id FROM invert02 ORDER BY keyword, doc_id;