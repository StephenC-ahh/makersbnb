CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text,
  password text
);

-- Then the table with the foreign key first.
CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  title text,
  description text,
  price_per_night int,
  start_date DATE,
  end_date DATE,
-- The foreign key name is always {user}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

INSERT INTO users(username, email_address, password) VALUES ('Jack', 'JackJones@gmail.com', 'SkyBlue123');
INSERT INTO users(username, email_address, password) VALUES ('Mike', 'Mike@gmail.com', 'Free1234');
INSERT INTO users(username, email_address, password) VALUES ('test', 'test@test.com', '1234');

INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Countryside Retreat', 'Amazing for a weekend away from the city', 45, '2022/09/10', '2022/10/20', 2);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Tiny home','Escape to a Romantic and Magical Hobbit Retreat', 90, '2022/09/21', '2022/09/30', 1);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Magical Glamping Hut','A beautifully converted 1945 boat nestled within a private forest overlooking the beautiful open fenland countryside.', 120, '2022/09/21', '2022/10/30', 3);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Stargaze in a Luxury Dome', 'Your dome has everything you need, a king size bed, orthopaedic memory foam mattress, Egyptian cotton sheets, furnished to the highest standard with plush towels and soft furnishings. There is even a telescope allowing you to gaze at the surface of the moon from the comfort of your bed.', 75, '2022/09/10', '2022/11/20', 3);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Unique and Secluded AirShip', 'Retreat to the deck of this sustainable getaway and gaze at the twinkling constellations under a cosy tartan blanket. AirShip 2 is an iconic, insulated aluminum pod designed by Roderick James with views of the Sound of Mull from dragonfly windows.', 90, '2022/09/10', '2022/10/20', 2);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Land Rover Hot Tub', 'The Bluebird Penthouse has beautiful panoramic views, 1950s charming vintage interior with a touch of luxury. The Hot Tub is in a vintage landrover. Features Gas pizza oven, double bed, bath, shower, toilet, cooker, fridge, table, radio, central heating, covered outdoor seating, Gas BBQ, chimnea/fire and wine cellar.', 75, '2022/09/10', '2022/10/20', 1);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('The Old Sunday School', 'The Old Sunday School is in the grounds of a Grade-II listed Georgian rectory, opposite a medieval church. It has been newly converted and refurbished in an open-plan contemporary style, and finished to a very high specification. It has a private entrance and garden and patio area. Guests have access to the hosts seven-acre landscaped garden in an area of outstanding natural beauty. In the summer months [MAY-mid SEPTEMBER] guests will have shared use of the outdoor pool with the owners.', 90, '2022/09/10', '2022/10/20', 2);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('16th Century Dovecot Cottage in Private Garden.', 'In central Edinburgh yet tucked-away in a mature private garden, this quirky, sophisticated dovecot is stunning. Serene & secluded, its quietly thrilling. Wooden stairs lead to a tiny bedroom in the tower, where cedar-wood, lit ancient dove-nesting boxes & a garden view surround a double bed. Downstairs there is a sleek bathroom; a rustic-chic kitchen beneath mezzanine; a pull-out sofa-bed and a mysterious cavern can be glimpsed beneath a glass floor-panel.', 110, '2022/09/10', '2022/10/20', 3);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Moon Conker, unique riverside tree pod with fire', 'If you’ve been dreaming of rewilding yourself during lockdown. If you want to swing axes, build fires, and create your own Moon Bathing experience, this is the Conker for you.
With the Moon Conker the central feature is the Moon Bathing in two hot and cold Scandi-style baths filled by hand pump with water from the nearby stream and heated in a kettle.
Run back to your comfy bed to stretch out in front of the fire, gazing at the starry night skies through the observatory portholes above you.', 120, '2022/09/10', '2022/10/20', 1);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Shepherds Hut, Off-Grid and Hot Tub', 'A Tiny House, off-grid Shepherds Hut with panoramic views of the spectacular Brecon Beacons. Accessed by its own gated lane and set in a private paddock, Oliveduck Hut is the perfect retreat for couples, or singles who prefer their own company. An ideal ‘base camp’ as you explore the National Park and surrounding area. Light a fire and get lazy, chill out in the hot-tub, star-gaze at the incredible night skies, or just take in the majestic Pen y Fan as you plan (or recover from) your ascent.', 500, '2022/09/10', '2022/10/20', 2);