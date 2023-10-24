
USE hotel;

INSERT INTO amenityDetails (name)
VALUES
('microwave'),
('jacuzzi'),
('refrigerator'),
('oven');

INSERT INTO addressDetails
(address, city, stateAbbr, zip)
VALUES
('30 Luther Close', 'London', 'UK', '22019'),
('379 Old Shore Street', 'Council Bluffs', 'IA', '51501'),
('750 Wintergreen Dr.', 'Wasilla', 'AK', '99654'),
('9662 Foxrun Lane', 'Harlingen', 'TX', '78552'),
('9378 W. Augusta Ave.', 'West Deptford', 'NJ', '08096'),
('762 Wild Rose Street', 'Saginaw', 'MI', '48601'),
('7 Poplar Dr.', 'Arvada', 'CO', '80003'),
('70 Oakwood St.', 'Zion', 'IL', '60099'),
('7556 Arrowhead St.', 'Cumberland', 'RI', '02864'),
('77 West Surrey Street', 'Oswego', 'NY', '13126'),
('939 Linda Rd.', 'Burke', 'VA', '22015'),
('87 Queen St.', 'Drexel Hill', 'PA', '19026');


INSERT INTO guest 
(firstName, lastName, addressId, phone)
VALUES
('Gabriela', 'Angelica', 1, '(447) 424-6567'),
('Mark', 'Simmer', 2, '(291) 553-0508'),
('Bettyann ', 'Seery', 3, '(478) 277-9632'),
('Duane ', 'Cullison', 4,  '(308) 494-0198'),
('Karie ', 'Yang', 5, '(214) 730-0298'),
('Aurore', 'Luechtefeld', 6, '(377) 507-0974'),
('Zachery', 'Seery', 7, '(814) 485-2615'),
('Jeremiah', 'Pendergrass', 8,'(279) 491-0960'),
('Walter', 'Holaway', 9,'(446) 396-6785'),
('Wilfred', 'Vise', 10, '(834) 727-1001'),
('Maritza', 'Tilton', 11, '(446) 351-6860'),
('Joleen', 'Tison', 12, '(231) 893-2755');

INSERT INTO roomType 
(roomTypeName, standardOccupancy, maximumOccupancy, extraPersonCost)
VALUES
('double', 2, 4, 10.00),
('single', 2, 2, null),
('suite', 3, 8, 20.00);


INSERT INTO room 
(roomId, adaAccessible, roomTypeId, basePrice)
VALUE
(201, 0, 1, 199.99),
(202, 1, 1, 174.99),
(203, 0, 1, 199.99),
(204, 1, 1, 174.99),
(205, 0, 2, 174.99),
(206, 1, 2, 149.99),
(207, 0, 2, 174.99),
(208, 1, 2, 149.99),
(301, 0, 1, 199.99),
(302, 1, 1, 174.99),
(303, 0, 1, 199.99),
(304, 1, 1, 174.99),
(305, 0, 2, 174.99),
(306, 1, 2, 149.99),
(307, 0, 2, 174.99),
(308, 1, 2, 149.99),
(401, 0, 3, 399.99),
(402, 1, 3, 399.99);

INSERT INTO roomAmenities
(roomId, amenityId)
VALUES
(201, 1),
(201, 2),
(202, 3),
(203, 1),
(203, 2),
(204, 3),
(205, 1),
(205, 3),
(205, 2),
(206, 1),
(206, 3),
(207, 1),
(207, 3),
(207, 2),
(208, 1),
(208, 3),
(301, 1),
(301, 2),
(302, 3),
(303, 1),
(303, 2),
(304, 3),
(305, 1),
(305, 3),
(305, 2),
(306, 1),
(306, 3),
(307, 1),
(307, 3),
(307, 2),
(308, 1),
(308, 3),
(401, 1),
(401, 3),
(401, 4),
(402, 1),
(402, 3),
(402, 4);


INSERT INTO reservationDetails
(startDate, endDate, guestId, quantityAdults, quantityChildren)
VALUES
( '2023-2-2', '2023-2-4', 2, 1, 0),
( '2023-2-5', '2023-2-10', 3, 2, 1),
( '2023-2-22', '2023-2-24', 4, 2, 0),
( '2023-3-6', '2023-3-7', 5, 2, 2),
('2023-3-17', '2023-3-20', 1, 1, 1),
( '2023-3-18', '2023-3-23', 6, 3, 0),
( '2023-3-29', '2023-3-31', 7, 2, 2),
( '2023-3-31', '2023-4-5', 8, 2, 0),
( '2023-4-9', '2023-4-13', 9, 1, 0),
( '2023-4-23', '2023-4-24', 10, 1, 1),
( '2023-5-30', '2023-6-2', 11, 2, 4),
( '2023-6-10', '2023-6-14', 12, 2, 0), 
( '2023-6-10', '2023-6-14', 12, 1, 0),
( '2023-6-17', '2023-6-18', 6, 3, 0),
( '2023-6-28', '2023-7-2', 1, 2, 0),
( '2023-7-13', '2023-7-14', 9, 3, 1),
( '2023-7-18', '2023-7-21', 10, 4, 2),
( '2023-7-28', '2023-7-29', 3, 2, 1),
( '2023-8-30', '2023-9-1', 3, 1, 0),
( '2023-9-16', '2023-9-17', 2, 2, 0),
( '2023-9-13', '2023-9-15', 5, 2, 2),
( '2023-11-22', '2023-11-25', 4, 2, 2),
( '2023-11-22', '2023-11-25', 2, 2, 0),
( '2023-11-22', '2023-11-25', 2, 2, 2),
( '2023-12-24', '2023-12-28', 11, 2, 0);

INSERT INTO roomsReserved
(roomId, reservationId)
VALUES
(308, 1),
(203, 2),
(305, 3),
(201, 4),
(307, 5),
(302, 6),
(202, 7),
(304, 8),
(301, 9),
(207, 10),
(401, 11),
(206, 12),
(208, 13),
(304, 14),
(205, 15),
(204, 16),
(401, 17),
(303, 18),
(305, 19),
(208, 20),
(203, 21),
(401, 22),
(206, 23),
(301, 24),
(302, 25);

SELECT * FROM guest;
SELECT * FROM addressDetails;
SELECT * FROM amenityDetails;
SELECT * FROM roomType;
SELECT * FROM room;
SELECT * FROM roomAmenities;
SELECT * FROM reservationDetails;
SELECT * FROM roomsReserved;

-- delete Jeremiaj Pendergrass and his reservation
-- first, need to delete the roomsReserved(), then the reservation (where guestID is FK), then the guest entry (could have used Cascade DELETE)

DELETE FROM roomsReserved WHERE reservationId=(
	SELECT reservationDetails.guestId FROM reservationDetails
		WHERE reservationDetails.guestId = (
	SELECT guest.guestId
    FROM guest
    WHERE firstName="Jeremiah" AND lastName ="Pendergrass"));

DELETE FROM reservationDetails 
WHERE reservationDetails.guestId = (
	SELECT guest.guestId
    FROM guest
    WHERE firstName="Jeremiah" AND lastName ="Pendergrass");
    
DELETE FROM guest WHERE firstName="Jeremiah" AND lastName ="Pendergrass";