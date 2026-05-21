CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    title TEXT,
    levels INTEGER
);

CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    company TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    postal_code TEXT,
    phone TEXT,
    fax TEXT,
    email TEXT,
    support_rep_id INTEGER,
    FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id)
);

CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    invoice_date DATETIME,
    billing_address TEXT,
    billing_city TEXT,
    billing_state TEXT,
    billing_country TEXT,
    billing_postal_code TEXT,
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE genre (
    genre_id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE artist (
    artist_id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    title TEXT,
    artist_id INTEGER,
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

CREATE TABLE track (
    track_id INTEGER PRIMARY KEY,
    name TEXT,
    album_id INTEGER,
    media_type_id INTEGER,
    genre_id INTEGER,
    composer TEXT,
    milliseconds INTEGER,
    bytes INTEGER,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (album_id) REFERENCES album(album_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

CREATE TABLE invoice_line (
    invoice_line_id INTEGER PRIMARY KEY,
    invoice_id INTEGER,
    track_id INTEGER,
    unit_price DECIMAL(10,2),
    quantity INTEGER,
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
    FOREIGN KEY (track_id) REFERENCES track(track_id)
);

-- Insert dummy data to allow testing
INSERT INTO employee (employee_id, first_name, last_name, title, levels) VALUES
(1, 'Adams', 'Andrew', 'General Manager', 6),
(2, 'Edwards', 'Nancy', 'Sales Manager', 5),
(3, 'Peacock', 'Jane', 'Sales Support Agent', 3);

INSERT INTO customer (customer_id, first_name, last_name, country, email) VALUES
(1, 'Luís', 'Gonçalves', 'Brazil', 'luisg@embraer.com.br'),
(2, 'Leonie', 'Köhler', 'Germany', 'leonekohler@surfeu.de'),
(3, 'François', 'Tremblay', 'Canada', 'ftremblay@gmail.com');

INSERT INTO invoice (invoice_id, customer_id, invoice_date, billing_city, billing_country, total) VALUES
(1, 1, '2023-01-01', 'São José dos Campos', 'Brazil', 3.98),
(2, 2, '2023-02-01', 'Stuttgart', 'Germany', 8.91),
(3, 3, '2023-03-01', 'Montréal', 'Canada', 5.94),
(4, 1, '2023-04-01', 'São José dos Campos', 'Brazil', 13.86),
(5, 3, '2023-04-15', 'Montréal', 'Canada', 0.99);

INSERT INTO genre (genre_id, name) VALUES (1, 'Rock'), (2, 'Jazz');
INSERT INTO artist (artist_id, name) VALUES (1, 'AC/DC'), (2, 'Miles Davis');
INSERT INTO album (album_id, title, artist_id) VALUES (1, 'For Those About to Rock', 1), (2, 'Kind of Blue', 2);
INSERT INTO track (track_id, name, album_id, genre_id, milliseconds, unit_price) VALUES
(1, 'For Those About to Rock (We Salute You)', 1, 1, 343719, 0.99),
(2, 'Put The Finger On You', 1, 1, 205662, 0.99),
(3, 'So What', 2, 2, 544000, 0.99);

INSERT INTO invoice_line (invoice_line_id, invoice_id, track_id, unit_price, quantity) VALUES
(1, 1, 1, 0.99, 1),
(2, 1, 2, 0.99, 1),
(3, 2, 1, 0.99, 5),
(4, 3, 3, 0.99, 2);
