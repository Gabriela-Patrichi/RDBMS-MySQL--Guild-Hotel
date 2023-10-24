USE hotel;

-- 1. Write a query that returns a list of reservations that end in July 2023 (07/2023)
-- including the name of the guest, the room number(s), and the reservation dates.

-- use inner joins to connect tables, using their common field (guetsId,reservationId,roomId), where July 2023 reservation details start and end date are added
SELECT 
	reservationDetails.reservationId,
    guest.firstName,
    guest.lastName,
    room.roomId,
    reservationDetails.startDate,
    reservationDetails.endDate
FROM
    reservationDetails
        INNER JOIN 
    guest ON reservationDetails.guestId = guest.guestId
        INNER JOIN
    roomsReserved ON roomsReserved.reservationId = reservationDetails.reservationId
        INNER JOIN
    room ON room.roomId = roomsReserved.roomId
WHERE
    MONTH(reservationDetails.endDate) = 7
        AND YEAR(reservationDetails.endDate) = 2023;

/* Result
15	Gabriela	Angelica	205	2023-06-28	2023-07-02
18	Bettyann 	Seery	303	2023-07-28	2023-07-29
16	Walter	Holaway	204	2023-07-13	2023-07-14
17	Wilfred	Vise	401	2023-07-18	2023-07-21
*/

-- 2. Write a query that returns a list of reservations for rooms with
-- a jacuzzi, displaying the guest's name, the room number, and the dates
-- of the reservation.

-- use inner joins to connect tables, using their common field (guetsId,reservationId, roomId, amenityId), with a Where amenity.name="Jacuzzi" condition
SELECT 
    reservationDetails.reservationId,
    guest.firstName,
    guest.lastName,
    room.roomId,
    reservationDetails.startDate,
    reservationDetails.endDate
FROM
    reservationDetails
        INNER JOIN
    guest ON reservationDetails.guestId = guest.guestId
        INNER JOIN
    roomsReserved ON roomsReserved.reservationId = reservationDetails.reservationId
        INNER JOIN
    room ON room.roomId = roomsReserved.roomId
        INNER JOIN
    roomAmenities ON roomAmenities.roomId = room.roomId
        INNER JOIN
    amenityDetails ON amenityDetails.amenityId = roomAmenities.amenityId
WHERE
    amenityDetails.name = 'Jacuzzi';

/* Result
4	Karie 	Yang	201	2023-03-06	2023-03-07
2	Bettyann 	Seery	203	2023-02-05	2023-02-10
21	Karie 	Yang	203	2023-09-13	2023-09-15
15	Gabriela	Angelica	205	2023-06-28	2023-07-02
10	Wilfred	Vise	207	2023-04-23	2023-04-24
9	Walter	Holaway	301	2023-04-09	2023-04-13
24	Mark	Simmer	301	2023-11-22	2023-11-25
18	Bettyann 	Seery	303	2023-07-28	2023-07-29
3	Duane 	Cullison	305	2023-02-22	2023-02-24
19	Bettyann 	Seery	305	2023-08-30	2023-09-01
5	Gabriela	Angelica	307	2023-03-17	2023-03-20
*/

-- 3. Write a query that returns all rooms reserved for a specific guest, including the guest's name, the room(s) reserved, the starting date of
-- the reservation, and how many people were included in the reservation. (choose a guest's name from the existing data.)

-- again inner join to join the tables, using common columns
-- Gabriela Angelica (guest full name) was choosen as an example
SELECT DISTINCT
	reservationDetails.reservationId,
    room.roomId,
    guest.firstName,
    guest.lastName,
    reservationDetails.startDate,
    reservationDetails.endDate,
    reservationDetails.quantityAdults + reservationDetails.quantityChildren AS quantity_people -- define quantity_people as the total nr of people for the reservation
FROM
    reservationDetails
        INNER JOIN
    guest ON reservationDetails.guestId = guest.guestId
        INNER JOIN
    roomsReserved ON roomsReserved.reservationId = reservationDetails.reservationId
        INNER JOIN
    room ON room.roomId = roomsReserved.roomId
        INNER JOIN
    roomAmenities ON roomAmenities.roomId = room.roomId
        INNER JOIN
    amenityDetails ON amenityDetails.amenityId = roomAmenities.amenityId
WHERE
    guest.firstName = 'Gabriela'
        AND guest.lastName = 'Angelica';

/* Result
5	307	Gabriela	Angelica	2023-03-17	2023-03-20	2
15	205	Gabriela	Angelica	2023-06-28	2023-07-02	2
*/

-- 4. Write a query that returns a list of rooms, reservation ID and per-room cost for each reservation.
--  The results should include all rooms, whether or not there is a reservation associated with the room.

-- here the total cost values has been calculated as base price * nights in (end date - start date) + extra person cost * (total occupancy - maximum occupancy)
SELECT 
    room.roomId,
    reservationDetails.reservationId,
    CASE
        WHEN
            (reservationDetails.quantityAdults - roomType.standardOccupancy) > 0
        THEN
            room.basePrice * DATEDIFF(reservationDetails.endDate,
                    reservationDetails.startDate) + (reservationDetails.quantityAdults - roomType.standardOccupancy) * roomType.extraPersonCost
        ELSE room.basePrice * DATEDIFF(reservationDetails.endDate,
                reservationDetails.startDate)
    END AS total_room_cost
FROM
    room
        LEFT JOIN
    roomsReserved ON roomsReserved.roomId = room.roomId
        LEFT JOIN
    reservationDetails ON reservationDetails.reservationId = roomsReserved.reservationId
        LEFT JOIN
    roomType ON roomType.roomTypeId = room.roomTypeId
ORDER BY roomId;

/* Result
# roomId, reservationId, total_room_cost
'201', '4', '199.99'
'202', '7', '349.98'
'203', '2', '999.95'
'203', '21', '399.98'
'204', '16', '184.99'
'205', '15', '699.96'
'206', '12', '599.96'
'206', '23', '449.97'
'207', '10', '174.99'
'208', '13', '599.96'
'208', '20', '149.99'
'301', '9', '799.96'
'301', '24', '599.97'
'302', '6', '884.95'
'302', '25', '699.96'
'303', '18', '199.99'
'304', '8', '874.95'
'304', '14', '184.99'
'305', '3', '349.98'
'305', '19', '349.98'
'306', NULL, NULL
'307', '5', '524.97'
'308', '1', '299.98'
'401', '11', '1199.97'
'401', '17', '1219.97'
'401', '22', '1199.97'
'402', NULL, NULL
*/


-- 5. Write a query that returns all rooms with a capacity of three or more and that are reserved on any date in April 2023.

-- inner join room, roomReserved, reservationDetails, roomType 
-- where roomType.maximumOccupancy>=3, and month=4
SELECT 
    room.roomId,
    roomType.maximumOccupancy,
    reservationDetails.startDate,
    reservationDetails.endDate
FROM
    room
        INNER JOIN
    roomsReserved ON roomsReserved.roomId = room.roomId
        INNER JOIN
    reservationDetails ON reservationDetails.reservationId = roomsReserved.reservationId
        INNER JOIN
    roomType ON roomType.roomTypeId = room.roomTypeId
WHERE
    roomType.maximumOccupancy >= 3
        AND MONTH(reservationDetails.startDate) = 4;

/* Result
# roomId, maximumOccupancy, reservationId, startDate, endDate
'301', '4', '9', '2023-04-09', '2023-04-13'
*/

-- 6. Write a query that returns a list of all guest names and the no. of reservations
-- per guest, sorted starting with the guest with the most reservations and then by the guest's last name.

-- inner join to connect guest with reservationDetails (using guestId) , group by 
-- order reservations count asc and desc guest name
SELECT 
    guest.firstName,
    guest.lastName,
    COUNT(reservationDetails.guestId) reservationCount
FROM
    guest
        INNER JOIN
    reservationDetails ON reservationDetails.guestId = guest.guestId
GROUP BY guest.guestId
ORDER BY reservationCount DESC, guest.lastName;

/*  Result
# firstName, lastName, reservationCount
'Mark', 'Simmer', '4'
'Bettyann ', 'Seery', '3'
'Duane ', 'Cullison', '2'
'Gabriela', 'Angelica','2'
'Walter', 'Holaway', '2'
'Aurore', 'Luechtefeld', '2'
'Maritza', 'Tilton', '2'
'Joleen', 'Tison', '2'
'Wilfred', 'Vise', '2'
'Karie ', 'Yang', '2'
'Zachery', 'Seery', '1'
*/

-- 7. Write a query that displays the name, address and phone number of
-- a guest based on their phone number. (Choose a phone number from the existing data).

-- left join (addressId common value) returning all guest values and the matching values from addressDetails
SELECT 
    guest.firstName,
    guest.lastName,
    addressDetails.address,
    addressDetails.city,
    addressDetails.stateAbbr,
    addressDetails.zip,
    guest.phone
FROM
    addressDetails
        LEFT JOIN
    guest ON addressDetails.addressId = guest.addressId
WHERE
    guest.phone = '(377) 507-0974';
    
/* Result
# firstName, lastName, address, city, stateAbbr, zip, phone
'Aurore', 'Luechtefeld', '762 Wild Rose Street', 'Saginaw', 'MI', '48601', '(377) 507-0974'
*/



