CREATE DATABASE travelAgency;

CREATE TABLE Clients (
    CL_ID SERIAL PRIMARY KEY,
    CL_FirstName VARCHAR(50) NOT NULL CHECK(CL_FirstName ~ '^[A-Z][a-z]+$'),
    CL_LastName VARCHAR(50) NOT NULL,
    CL_DateOfBirth DATE CHECK(CL_DateOfBirth <= CURRENT_DATE),
    CL_Phone VARCHAR(20) UNIQUE CHECK(CL_Phone ~ '^[0-9]{10,20}$'),
    CL_Email VARCHAR(100) UNIQUE NOT NULL CHECK(CL_Email <> ''),
    CL_Address VARCHAR(255)
);

CREATE TABLE Tours (
    TR_ID SERIAL PRIMARY KEY,
    TR_Name VARCHAR(100) NOT NULL,
    TR_Description TEXT,
    TR_Price DECIMAL(10, 2) CHECK(TR_Price > 0),
    TR_StartDate DATE CHECK(TR_StartDate >= CURRENT_DATE),
    TR_EndDate DATE CHECK (TR_EndDate >= TR_StartDate),
    TR_TourType VARCHAR(20) CHECK(TR_TourType IN ('Leisure', 'Excursion', 'Business trip')) NOT NULL,
    TR_Destination VARCHAR(100) NOT NULL
);

CREATE TABLE Bookings (
    BK_ID SERIAL PRIMARY KEY,
    BK_Date DATE,
    BK_Status VARCHAR(20),
    BK_TotalAmount DECIMAL(10, 2),
    BK_CL_ID INT NOT NULL REFERENCES Clients(CL_ID) 
                 ON UPDATE CASCADE
                 ON DELETE RESTRICT,
    BK_TR_ID INT NOT NULL REFERENCES Tours(TR_ID) 
                 ON UPDATE CASCADE
                 ON DELETE RESTRICT
);

CREATE TABLE Transportation (
    TRP_ID SERIAL PRIMARY KEY,
    TRP_Type VARCHAR(20) NOT NULL CHECK(TRP_Type IN ('Airplane', 'Train', 'Bus', 'Car')),
    TRP_CarrierName VARCHAR(100),
    TRP_Cost DECIMAL(10, 2) CHECK(TRP_Cost >= 0),
    TRP_Phone VARCHAR(20) NOT NULL UNIQUE CHECK(TRP_Phone ~ '^[0-9]{10,20}$'),
    TRP_Email VARCHAR(100) NOT NULL UNIQUE CHECK(TRP_Email <> '')
);

CREATE TABLE Tour_Transportation (
    TT_ID SERIAL PRIMARY KEY,
    TT_TR_ID INTEGER NOT NULL REFERENCES Tours(TR_ID) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    TT_TRP_ID INTEGER NOT NULL REFERENCES Transportation(TRP_ID) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Hotels (
    HT_ID SERIAL PRIMARY KEY,
    HT_Name VARCHAR(100) NOT NULL,
    HT_Address VARCHAR(255),
    HT_Category VARCHAR(20) NOT NULL CHECK(HT_Category IN ('Luxury', 'Resort', 'Business', 'Budget', 'Hostel', 'Motel')),
    HT_Stars INT CHECK(HT_Stars >= 3 AND HT_Stars <= 5),
    HT_Phone VARCHAR(20),
    HT_Email VARCHAR(100) NOT NULL UNIQUE CHECK(HT_Email <> '')
);

CREATE TABLE Tour_Hotels (
    TH_ID SERIAL PRIMARY KEY,
    TH_TR_ID INTEGER NOT NULL REFERENCES Tours(TR_ID) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    TH_HT_ID INTEGER NOT NULL REFERENCES Hotels(HT_ID) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Transportation(TRP_Type, TRP_CarrierName, TRP_Cost, TRP_Phone, TRP_Email) 
VALUES
    ('Airplane', 'Emirates', 500.00, '1234567890', 'contact@emirates.com'),
    ('Train', 'Emirates', 150.00, '2345678901', 'train@emirates.com'),
    ('Bus', 'Emirates', 50.00, '3456789012', 'bus@emirates.com'),
    ('Airplane', 'Lufthansa', 600.00, '4567890123', 'info@lufthansa.com'),
    ('Train', 'Lufthansa', 175.00, '5678901234', 'train@lufthansa.com'),
    ('Bus', 'Greyhound', 45.00, '6789012345', 'support@greyhound.com'),
    ('Car', 'Hertz', 200.00, '7890123456', 'rental@hertz.com'),
    ('Airplane', 'Delta', 550.00, '8901234567', 'info@delta.com'),
    ('Train', 'Delta', 180.00, '9012345678', 'train@delta.com'),
    ('Bus', 'Megabus', 50.00, '0123456789', 'info@megabus.com'),
    ('Car', 'Avis', 220.00, '1123456789', 'rental@avis.com'),
    ('Airplane', 'Qatar Airways', 700.00, '2123456789', 'info@qatarairways.com'),
    ('Bus', 'BoltBus', 40.00, '3123456789', 'info@boltbus.com'),
    ('Car', 'Enterprise', 250.00, '4123456789', 'rental@enterprise.com'),
    ('Airplane', 'Turkish Airlines', 580.00, '5123456789', 'support@turkishairlines.com'),
    ('Train', 'Renfe', 160.00, '6123456789', 'support@renfe.com'),
    ('Bus', 'Stagecoach', 60.00, '7123456789', 'contact@stagecoach.com'),
    ('Car', 'Sixt', 230.00, '8123456789', 'rental@sixt.com'),
    ('Airplane', 'British Airways', 680.00, '9123456789', 'info@britishairways.com'),
    ('Train', 'British Airways', 170.00, '1012345678', 'train@britishairways.com');

INSERT INTO Clients (CL_FirstName, CL_LastName, CL_DateOfBirth, CL_Phone, CL_Email, CL_Address) 
VALUES
    ('John', 'Doe', '1985-05-20', '1234567890', 'john.doe@example.com', '123 Elm Street, Springfield'),
    ('Jane', 'Smith', '1990-08-12', '2345678901', 'jane.smith@example.com', '456 Maple Avenue, Gotham'),
    ('Michael', 'Johnson', '1978-11-30', '3456789012', 'michael.johnson@example.com', '789 Oak Road, Metropolis'),
    ('Emily', 'Davis', '1995-02-10', '4567890123', 'emily.davis@example.com', '321 Pine Street, Star City'),
    ('Robert', 'Miller', '1982-07-25', '5678901234', 'robert.miller@example.com', '678 Cedar Lane, Central City'),
    ('Sophia', 'Brown', '1987-09-14', '6789012345', 'sophia.brown@example.com', '789 Birch Road, Smallville'),
    ('Daniel', 'Garcia', '1993-03-22', '7890123456', 'daniel.garcia@example.com', '321 Oak Avenue, Starling City'),
    ('David', 'Martinez', '1985-12-03', '8901234567', 'david.martinez@example.com', '432 Pine Street, Metropolis'),
    ('Anna', 'Taylor', '1992-07-19', '9012345678', 'anna.taylor@example.com', '543 Elm Lane, Gotham'),
    ('Mia', 'Anderson', '1994-04-15', '0123456789', 'mia.anderson@example.com', '654 Maple Road, Springfield'),
    ('Liam', 'Thomas', '1991-08-30', '1123456789', 'liam.thomas@example.com', '321 Birch Avenue, Central City'),
    ('Oliver', 'Moore', '1988-06-25', '2123456789', 'oliver.moore@example.com', '123 Cedar Street, Star City'),
    ('Ethan', 'Jackson', '1993-01-13', '3123456789', 'ethan.jackson@example.com', '432 Oak Road, Gotham'),
    ('Lucas', 'Lee', '1989-03-07', '4123456789', 'lucas.lee@example.com', '789 Pine Street, Metropolis'),
    ('William', 'White', '1986-10-21', '5123456789', 'william.white@example.com', '654 Birch Lane, Springfield'),
    ('Ella', 'Harris', '1997-02-25', '6123456789', 'ella.harris@example.com', '321 Maple Avenue, Smallville'),
    ('Mason', 'Clark', '1990-11-10', '7123456789', 'mason.clark@example.com', '432 Cedar Road, Gotham'),
    ('James', 'Lewis', '1982-04-18', '8123456789', 'james.lewis@example.com', '543 Pine Street, Star City'),
    ('Ava', 'Walker', '1994-09-05', '9123456789', 'ava.walker@example.com', '321 Oak Lane, Central City'),
    ('Henry', 'Hall', '1996-08-28', '1012345678', 'henry.hall@example.com', '654 Maple Street, Metropolis'),
    ('Charlotte', 'Allen', '1991-06-15', '1112345678', 'charlotte.allen@example.com', '789 Cedar Avenue, Gotham'),
    ('Jack', 'Young', '1995-03-12', '1212345678', 'jack.young@example.com', '123 Oak Road, Star City'),
    ('Lucas', 'Scott', '1989-12-11', '5012345678', 'lucas.scott@example.com', '321 Elm Street, Springfield'),
    ('Emma', 'Williams', '1990-01-15', '12015551234', 'emma.williams@example.com', '1 Main St, London, UK'),
    ('Liam', 'Smith', '1988-03-24', '12015552345', 'liam.smith@example.com', '2 High St, Sydney, Australia'),
    ('Noah', 'Brown', '1985-06-10', '12015553456', 'noah.brown@example.com', '3 Oak St, Toronto, Canada'),
    ('Olivia', 'Jones', '1995-05-22', '12015554567', 'olivia.jones@example.com', '4 Pine Rd, New York, USA'),
    ('Ava', 'Garcia', '1992-07-30', '12015555678', 'ava.garcia@example.com', '5 Maple St, Madrid, Spain'),
    ('Sophia', 'Martinez', '1989-09-15', '12015556789', 'sophia.martinez@example.com', '6 Elm St, Mexico City, Mexico'),
    ('Isabella', 'Hernandez', '1987-11-25', '12015557890', 'isabella.hernandez@example.com', '7 Cedar Ave, Buenos Aires, Argentina'),
    ('Mia', 'Lopez', '1991-04-18', '12015558901', 'mia.lopez@example.com', '8 Cherry Blvd, Paris, France'),
    ('Charlotte', 'Wilson', '1993-08-12', '12015559012', 'charlotte.wilson@example.com', '9 Birch Ln, Berlin, Germany'),
    ('Amelia', 'Anderson', '1994-12-07', '12015560123', 'amelia.anderson@example.com', '10 Fir Ct, Rome, Italy'),
    ('James', 'Thompson', '1986-10-11', '12015561234', 'james.thompson@example.com', '11 Spruce St, Tokyo, Japan'),
    ('Benjamin', 'Taylor', '1984-03-29', '12015562345', 'benjamin.taylor@example.com', '12 Walnut Dr, Beijing, China'),
    ('Lucas', 'Moore', '1990-07-03', '12015563456', 'lucas.moore@example.com', '13 Maple St, Johannesburg, South Africa'),
    ('Henry', 'Jackson', '1991-08-30', '12015564567', 'henry.jackson@example.com', '14 Palm Rd, Cairo, Egypt'),
    ('Alexander', 'Martin', '1987-05-25', '12015565678', 'alexander.martin@example.com', '15 Acacia Ave, Mumbai, India'),
    ('Jackson', 'Lee', '1995-06-14', '12015566789', 'jackson.lee@example.com', '16 Fir St, Seoul, South Korea'),
    ('Ella', 'Perez', '1988-01-18', '12015567890', 'ella.perez@example.com', '17 Cedar Ln, Sydney, Australia'),
    ('Grace', 'White', '1992-09-22', '12015568901', 'grace.white@example.com', '18 Olive St, London, UK'),
    ('Zoe', 'Harris', '1994-03-11', '12015569012', 'zoe.harris@example.com', '19 Oak St, Toronto, Canada'),
    ('Chloe', 'Clark', '1990-02-15', '12015570123', 'chloe.clark@example.com', '20 Maple Rd, San Francisco, USA');

INSERT INTO Hotels (HT_Name, HT_Address, HT_Category, HT_Stars, HT_Phone, HT_Email) 
VALUES
    ('Grand Plaza Hotel', '123 Main St, London, UK', 'Luxury', 5, '02079460001', 'info@grandplaza.com'),
    ('Seaside Resort', '456 Beach Ave, Miami, USA', 'Resort', 4, '3055550123', 'contact@seasideresort.com'),
    ('Business Inn', '789 Business Rd, New York, USA', 'Business', 4, '2125550134', 'info@businessinn.com'),
    ('Budget Stay', '321 Economy St, Toronto, Canada', 'Budget', 3, '4165550145', 'contact@budgetstay.com'),
    ('Cozy Hostel', '654 Backpacker Ln, Berlin, Germany', 'Hostel', 3, '0305550156', 'info@cozyhostel.com'),
    ('Mountain View Lodge', '987 Mountain Rd, Aspen, USA', 'Motel', 4, '9705550167', 'info@mountainviewlodge.com'),
    ('Ocean View Hotel', '159 Coastal Hwy, Sydney, Australia', 'Luxury', 5, '02-93331000', 'contact@oceanview.com'),
    ('City Center Hotel', '258 City Blvd, Tokyo, Japan', 'Business', 4, '03-12345678', 'info@citycenterhotel.com'),
    ('Riverside Inn', '357 River Rd, Paris, France', 'Resort', 4, '+33 1 23 45 67 89', 'info@riversideinn.com'),
    ('Royal Castle Hotel', '246 Palace St, Rome, Italy', 'Luxury', 5, '06-12345678', 'info@royalcastle.com'),
    ('Desert Oasis Hotel', '135 Desert Rd, Dubai, UAE', 'Resort', 5, '+971 4 123 4567', 'info@desertoasis.com'),
    ('Countryside Retreat', '369 Farm Ln, Melbourne, Australia', 'Motel', 3, '03-98765432', 'info@countrysideretreat.com'),
    ('Skyline Hotel', '741 Tower St, San Francisco, USA', 'Business', 4, '415-555-0198', 'info@skylinehotel.com'),
    ('Sunset Beach Resort', '852 Shore Rd, Cancun, Mexico', 'Resort', 4, '+52 998 123 4567', 'contact@sunsetbeach.com'),
    ('Green Valley Inn', '963 Green St, Nairobi, Kenya', 'Motel', 3, '+254 20 123456', 'info@greenvalleyinn.com'),
    ('Harbor View Hotel', '741 Harbor St, Seattle, USA', 'Luxury', 5, '206-555-0112', 'info@harborviewhotel.com'),
    ('Artisan Hotel', '852 Arts St, Lisbon, Portugal', 'Business', 4, '+351 21 123 4567', 'contact@artisanhotel.com'),
    ('Alpine Lodge', '963 Ski Rd, Zurich, Switzerland', 'Motel', 3, '+41 44 123 45 67', 'info@alpinelodge.com'),
    ('Forest Edge Hotel', '357 Wooded Rd, Vancouver, Canada', 'Luxury', 5, '604-555-0189', 'info@forestedgehotel.com'),
    ('Starview Resort', '159 Sky St, Las Vegas, USA', 'Resort', 4, '702-555-0178', 'contact@starviewresort.com'),
    ('Cultural Heritage Hotel', '753 Heritage Ln, Cairo, Egypt', 'Business', 4, '+20 2 12345678', 'info@culturalheritagehotel.com'),
    ('Tropical Paradise Resort', '1 Island Rd, Bali, Indonesia', 'Resort', 5, '+62 361 1234567', 'info@tropicalparadise.com'),
    ('Crystal Lake Hotel', '2 Lake St, Geneva, Switzerland', 'Luxury', 5, '+41 22 123 45 67', 'contact@crystallakehotel.com'),
    ('Urban Escape Hotel', '3 City Rd, Amsterdam, Netherlands', 'Business', 4, '+31 20 123 4567', 'info@urbanescape.com'),
    ('Sandy Shores Inn', '4 Beach Blvd, Phuket, Thailand', 'Resort', 4, '+66 76 123 456', 'contact@sandyshoresinn.com'),
    ('Mountain Peak Lodge', '5 Summit St, Denver, USA', 'Motel', 3, '303-555-0180', 'info@mountainpeaklodge.com'),
    ('Lake View Hotel', '6 Waterfall Rd, Toronto, Canada', 'Luxury', 5, '416-555-0199', 'info@lakeviewhotel.com'),
    ('Cultural Oasis Hotel', '7 Cultural Rd, Istanbul, Turkey', 'Business', 4, '+90 212 123 4567', 'contact@culturaloasis.com'),
    ('Grandview Resort', '8 Vista Ave, Santorini, Greece', 'Resort', 5, '+30 22860 12345', 'info@grandviewresort.com'),
    ('Wildflower Inn', '9 Blossom Rd, Wellington, New Zealand', 'Motel', 3, '+64 4 123 4567', 'info@wildflowerinn.com'),
    ('Cosmic Hotel', '10 Star St, Mumbai, India', 'Luxury', 5, '+91 22 12345678', 'info@cosmichotel.com'),
    ('Serenity Hotel', '11 Calm St, Dubrovnik, Croatia', 'Resort', 4, '+385 20 123 456', 'contact@serenityhotel.com'),
    ('Desert Mirage Inn', '12 Oasis Rd, Marrakech, Morocco', 'Motel', 3, '+212 5 24 12 34', 'info@desertmirage.com'),
    ('Harbor Lights Hotel', '13 Lighthouse Rd, Sydney, Australia', 'Luxury', 5, '02-1234 5678', 'info@harborlights.com'),
    ('Palm Tree Inn', '14 Coconut Ln, Honolulu, Hawaii, USA', 'Resort', 4, '808-555-0199', 'info@palmtreeinn.com'),
    ('Cityscape Hotel', '15 Skyline Blvd, Singapore', 'Business', 4, '+65 6123 4567', 'contact@cityscape.com'),
    ('Breezy Bay Resort', '16 Coastline Rd, Miami, USA', 'Resort', 4, '305-555-0134', 'info@breezybay.com'),
    ('Heritage House', '17 History Rd, Athens, Greece', 'Luxury', 5, '+30 21 1234 5678', 'info@heritagehouse.com'),
    ('Misty Mountain Lodge', '18 Foggy St, Vancouver, Canada', 'Motel', 3, '604-555-0188', 'info@mistymountainlodge.com'),
    ('Elegant Suites', '19 Classy Rd, Paris, France', 'Business', 4, '+33 1 12 34 56 78', 'contact@elegantsuites.com'),
    ('Island Getaway Hotel', '20 Paradise Rd, Bora Bora, French Polynesia', 'Resort', 5, '+689 40 123 456', 'info@islandgetaway.com');



INSERT INTO Tours (TR_Name, TR_Description, TR_Price, TR_StartDate, TR_EndDate, TR_TourType, TR_Destination)  
VALUES
    ('Cultural Journey to Japan', 'Explore the rich history and culture of Japan.', 2500.00, '2025-08-20', '2025-08-27', 'Excursion', 'Japan'),
    ('Island Hopping in Greece', 'Visit stunning islands and enjoy local cuisine.', 2200.00, '2025-09-03', '2025-09-10', 'Leisure', 'Greece'),
    ('Adventure in Costa Rica', 'Experience the beauty of nature and adventure sports.', 1800.00, '2025-09-17', '2025-09-24', 'Leisure', 'Costa Rica'),
    ('Historical Tour of Egypt', 'Visit the pyramids and explore ancient history.', 3000.00, '2025-10-01', '2025-10-08', 'Excursion', 'Egypt'),
    ('Road Trip through California', 'Discover the beautiful scenery of California.', 2000.00, '2025-10-15', '2025-10-22', 'Leisure', 'USA'),
    ('Wildlife Safari in Kenya', 'Experience wildlife in their natural habitat.', 2800.00, '2025-10-29', '2025-11-05', 'Excursion', 'Kenya'),
    ('Ski Trip in the Rockies', 'Enjoy skiing and winter sports in the Rockies.', 1500.00, '2025-11-12', '2025-11-19', 'Leisure', 'USA'),
    ('Meditation Retreat in Bali', 'Relax and rejuvenate in a serene environment.', 1700.00, '2025-11-26', '2025-12-03', 'Leisure', 'Bali'),
    ('Cruise through the Mediterranean', 'Enjoy a luxurious cruise experience.', 3500.00, '2025-12-10', '2025-12-17', 'Leisure', 'Mediterranean'),
    ('Business Conference in Dubai', 'Join an international business conference.', 2000.00, '2026-01-05', '2026-01-10', 'Business trip', 'Dubai'),
    ('Global Leadership Summit', 'Network with global leaders and innovators.', 2500.00, '2026-01-20', '2026-01-25', 'Business trip', 'New York'),
    ('Tech Conference in San Francisco', 'Explore the latest in technology.', 1800.00, '2026-02-03', '2026-02-08', 'Business trip', 'San Francisco'),
    ('Investment Seminar in London', 'Learn about global investment opportunities.', 2200.00, '2026-02-17', '2026-02-22', 'Business trip', 'London'),
    ('Luxury Business Retreat', 'A luxury retreat for executives.', 3000.00, '2026-03-01', '2026-03-06', 'Business trip', 'Switzerland'),
    ('Networking Event in Toronto', 'Expand your network at this exclusive event.', 2100.00, '2026-03-15', '2026-03-20', 'Business trip', 'Toronto'),
    ('Corporate Training in Paris', 'Enhance your skills in a beautiful city.', 2300.00, '2026-03-28', '2026-04-02', 'Business trip', 'Paris'),
    ('Culinary Tour in Italy', 'Taste the best of Italian cuisine.', 1600.00, '2026-04-12', '2026-04-19', 'Excursion', 'Italy'),
    ('Volcano Hiking in Iceland', 'Explore the natural wonders of Iceland.', 1800.00, '2026-04-26', '2026-05-03', 'Leisure', 'Iceland'),
    ('Northern Lights Experience', 'Witness the breathtaking Northern Lights.', 2400.00, '2026-05-10', '2026-05-17', 'Leisure', 'Norway'),
    ('Heritage Tour in India', 'Experience the rich cultural heritage of India.', 2000.00, '2026-05-24', '2026-05-31', 'Excursion', 'India'),
    ('Photography Tour in Patagonia', 'Capture the stunning landscapes of Patagonia.', 2200.00, '2026-06-07', '2026-06-14', 'Leisure', 'Argentina'),
    ('Eco-Tourism in Costa Rica', 'Experience sustainable tourism in beautiful landscapes.', 1900.00, '2026-06-21', '2026-06-28', 'Leisure', 'Costa Rica'),
    ('Art and Culture Tour in Barcelona', 'Explore the art and culture of Spain.', 2300.00, '2026-07-05', '2026-07-12', 'Excursion', 'Spain'),
    ('Business Trip to Sydney', 'Meet with Australian partners in a vibrant city.', 2100.00, '2026-07-19', '2026-07-26', 'Business trip', 'Australia'),
    ('Study Abroad Program in London', 'Expand your knowledge in one of the world`s greatest cities.', 2500.00, '2026-08-02', '2026-08-09', 'Business trip', 'London'),
    ('Health and Wellness Retreat', 'Focus on your health and well-being.', 1800.00, '2026-08-16', '2026-08-23', 'Leisure', 'Thailand'),
    ('Wine Tasting Tour in France', 'Indulge in the best wines of France.', 2000.00, '2026-08-30', '2026-09-06', 'Leisure', 'France'),
    ('Cruise in the Caribbean', 'Relax on a cruise through beautiful islands.', 3500.00, '2026-09-13', '2026-09-20', 'Leisure', 'Caribbean');


INSERT INTO Bookings (BK_Date, BK_Status, BK_TotalAmount, BK_CL_ID, BK_TR_ID)  
VALUES
    ('2024-10-15', 'Confirmed', 2500.00, 2, 7),
    ('2024-10-20', 'Pending', 2200.00, 3, 8),
    ('2024-10-25', 'Confirmed', 1800.00, 4, 9),
    ('2024-11-01', 'Cancelled', 3000.00, 6, 10),
    ('2024-11-10', 'Confirmed', 2000.00, 7, 11),
    ('2024-11-15', 'Pending', 2800.00, 8, 12),
    ('2024-11-22', 'Confirmed', 1500.00, 9, 13),
    ('2024-11-30', 'Confirmed', 1700.00, 10, 14),
    ('2024-12-05', 'Pending', 3500.00, 11, 15),
    ('2024-12-10', 'Cancelled', 2000.00, 12, 16),
    ('2024-12-15', 'Confirmed', 2500.00, 13, 17),
    ('2025-01-05', 'Confirmed', 2200.00, 14, 18),
    ('2025-01-12', 'Pending', 1800.00, 16, 19),
    ('2025-01-20', 'Confirmed', 3000.00, 17, 20),
    ('2025-02-05', 'Cancelled', 2000.00, 18, 21),
    ('2025-02-12', 'Confirmed', 2800.00, 19, 22),
    ('2025-02-20', 'Confirmed', 1500.00, 20, 23),
    ('2025-03-01', 'Pending', 1700.00, 21, 24),
    ('2025-03-10', 'Confirmed', 3500.00, 22, 25),
    ('2025-03-15', 'Cancelled', 2000.00, 23, 26),
    ('2025-03-22', 'Confirmed', 2500.00, 24, 27),
    ('2025-04-05', 'Confirmed', 2200.00, 28, 28),
    ('2025-04-12', 'Pending', 1800.00, 29, 29),
    ('2025-04-20', 'Confirmed', 3000.00, 30, 30),
    ('2025-05-05', 'Cancelled', 2000.00, 31, 31),
    ('2025-05-12', 'Confirmed', 2800.00, 32, 32),
    ('2025-05-20', 'Confirmed', 1500.00, 33, 33),
    ('2025-05-30', 'Pending', 1700.00, 34, 34),
    ('2025-06-05', 'Confirmed', 3500.00, 36, 7),
    ('2025-06-10', 'Confirmed', 2200.00, 37, 8),
    ('2025-06-15', 'Pending', 1800.00, 38, 9),
    ('2025-07-01', 'Cancelled', 3000.00, 39, 10),
    ('2025-07-10', 'Confirmed', 2000.00, 40, 11),
    ('2025-07-15', 'Pending', 2800.00, 41, 12),
    ('2025-07-22', 'Confirmed', 1500.00, 42, 13),
    ('2025-07-30', 'Confirmed', 1700.00, 43, 14),
    ('2025-08-05', 'Pending', 3500.00, 44, 15),
    ('2025-08-10', 'Cancelled', 2000.00, 46, 16);

INSERT INTO Tour_Hotels (TH_TR_ID, TH_HT_ID)
VALUES
    (7, 1),
    (8, 2),
    (9, 3),
    (10, 4),
    (11, 5),
    (12, 6),
    (13, 7),
    (14, 8),
    (15, 9),
    (16, 10),
    (17, 11),
    (18, 12),
    (19, 13),
    (20, 14),
    (21, 15),
    (22, 16),
    (23, 17),
    (24, 18),
    (25, 19),
    (26, 20),
    (27, 21),
    (28, 22),
    (29, 23),
    (30, 24),
    (31, 25),
    (32, 26),
    (33, 27),
    (34, 28);

INSERT INTO Tour_Transportation (TT_TR_ID, TT_TRP_ID)
VALUES
    (7, 1),
    (8, 2),
    (9, 3),
    (10, 4),
    (11, 5),
    (12, 6),
    (13, 7),
    (14, 8),
    (15, 9),
    (16, 10),
    (17, 11),
    (18, 12),
    (19, 13),
    (20, 14),
    (21, 15),
    (22, 16),
    (23, 17),
    (24, 18),
    (25, 19),
    (26, 20),
    (27, 1),
    (28, 2),
    (29, 3),
    (30, 4),
    (31, 5),
    (32, 6),
    (33, 7),
    (34, 8);

-- відобразити інформацію про замовлення конкретного клієнта
SELECT 
    CONCAT(C.CL_FirstName, ' ', C.CL_LastName) AS ClientName,
    B.BK_ID AS BookingID,
    B.BK_Date AS BookingDate,
    B.BK_Status AS Status,
    B.BK_TotalAmount AS TotalAmount,
    T.TR_Name AS TourName,
    T.TR_Price AS TourPrice,
    T.TR_StartDate AS StartDate,
    T.TR_EndDate AS EndDate,
    T.TR_TourType AS TourType,
    T.TR_Destination AS Destination
FROM 
    Bookings B
JOIN 
    Clients C ON B.BK_CL_ID = C.CL_ID
JOIN 
    Tours T ON B.BK_TR_ID = T.TR_ID
WHERE 
    C.CL_ID = 2;

-- перелік турів, оформлених в цьому місяці

SELECT 
    CONCAT(C.CL_FirstName, ' ', C.CL_LastName) AS ClientName,
    B.BK_ID AS BookingID,
    B.BK_Date AS BookingDate,
    B.BK_Status AS Status,
    B.BK_TotalAmount AS TotalAmount,
    T.TR_Name AS TourName,
    T.TR_Description AS TourDescription,
    T.TR_Price AS TourPrice,
    T.TR_StartDate AS StartDate,
    T.TR_EndDate AS EndDate,
    T.TR_TourType AS TourType,
    T.TR_Destination AS Destination
FROM 
    Bookings B
JOIN 
    Clients C ON B.BK_CL_ID = C.CL_ID
JOIN 
    Tours T ON B.BK_TR_ID = T.TR_ID
WHERE 
    EXTRACT(MONTH FROM B.BK_Date) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM B.BK_Date) = EXTRACT(YEAR FROM CURRENT_DATE);

-- сумарна вартість замовлень кожного клієнта

SELECT 
    CONCAT(C.CL_FirstName, ' ', C.CL_LastName) AS ClientName,
    SUM(B.BK_TotalAmount) AS TotalAmountSpent
FROM 
    Bookings B
JOIN 
    Clients C ON B.BK_CL_ID = C.CL_ID
GROUP BY 
    C.CL_FirstName, C.CL_LastName
ORDER BY 
    TotalAmountSpent DESC;

-- перелік продажів за конкретний тиждень

SELECT 
    B.BK_ID,
    CONCAT(C.CL_FirstName, ' ', C.CL_LastName) AS ClientName,
    B.BK_Date,
    B.BK_TotalAmount
FROM 
    Bookings B
JOIN 
    Clients C ON B.BK_CL_ID = C.CL_ID
WHERE 
    EXTRACT(WEEK FROM B.BK_Date) = 43 AND
    EXTRACT(YEAR FROM B.BK_Date) = 2024
ORDER BY 
    B.BK_Date;

-- виручку за місяць (сума всіх замовлень за місяць)

SELECT SUM(BK_TotalAmount) AS TotalRevenue
FROM Bookings
WHERE EXTRACT(YEAR FROM BK_Date) = 2024
  AND EXTRACT(MONTH FROM BK_Date) = 10;

-- список клієнтів, які обслуговувалися цього місяця

SELECT c.CL_FirstName || ' ' || c.CL_LastName AS FullName
FROM Clients c
JOIN Bookings b ON c.CL_ID = b.BK_CL_ID
WHERE EXTRACT(YEAR FROM b.BK_Date) = EXTRACT(YEAR FROM CURRENT_DATE)
  AND EXTRACT(MONTH FROM b.BK_Date) = EXTRACT(MONTH FROM CURRENT_DATE);

-- топ 5 турів за рік

SELECT t.TR_Name, COUNT(b.BK_ID) AS NumberOfBookings
FROM Tours t
JOIN Bookings b ON t.TR_ID = b.BK_TR_ID
GROUP BY t.TR_ID, t.TR_Name
ORDER BY NumberOfBookings DESC
LIMIT 5;

-- ID-турів які повторювалисяналежать проміжку від 7 до 16
-- Наш результат: 16 10 13 14 11

-- Ваш прибуток від продажу за місяць, за умови, 
-- що Ваш додаток отримує 3% від суми замовлення

SELECT 
    SUM(BK_TotalAmount) * 0.03 AS Profit
FROM 
    Bookings
WHERE 
    EXTRACT(YEAR FROM BK_Date) = 2024 AND
    EXTRACT(MONTH FROM BK_Date) = 10; 
