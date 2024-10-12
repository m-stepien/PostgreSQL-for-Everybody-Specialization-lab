CREATE TABLE docs01 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE TABLE invert01 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs01(id) ON DELETE CASCADE
);

INSERT INTO docs01 (doc) VALUES
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

insert into invert01(doc_id, keyword) select distinct d.id, lower(s.keyword) as keyword from docs01 as d, unnest(string_to_array(d.doc, ' ')) s(keyword) order by keyword, d.id; 

SELECT keyword, doc_id FROM invert01 ORDER BY keyword, doc_id LIMIT 10;