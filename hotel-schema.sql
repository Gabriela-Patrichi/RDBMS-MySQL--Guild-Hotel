-- Defining the Database
DROP DATABASE IF EXISTS hotel;
CREATE DATABASE hotel;
USE hotel;

-- room details table - roomTypeId PK
CREATE TABLE roomType ( 
	roomTypeId INT NOT NULL AUTO_INCREMENT, 
    roomTypeName VARCHAR(15),
    standardOccupancy INT NOT NULL,
    maximumOccupancy INT NOT NULL,
    extraPersonCost DECIMAL(10,2),
    CONSTRAINT pk_roomTypes
		PRIMARY KEY (roomTypeId)
);

-- room details table  - roomID PK, roomTypeID FK 
-- room (M) --- (1) roomType
CREATE TABLE room (
	roomId INT NOT NULL,
    adaAccessible BOOLEAN NOT NULL,
    roomTypeId INT NOT NULL,
    basePrice DOUBLE(10,2),
    CONSTRAINT pk_room
		PRIMARY KEY (roomId),
	CONSTRAINT fk_room_roomType
		FOREIGN KEY (roomTypeId)
		REFERENCES roomType(roomTypeId)
);

-- amenityDetails table - amenityId PK
CREATE TABLE amenityDetails (
	amenityId INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_amenityDetails
		PRIMARY KEY (amenityId)
);

-- because room (M) -- (M) roomAMenities
-- create new table, composite PK
CREATE TABLE roomAmenities (
	roomId INT NOT NULL,
	amenityId INT NOT NULL,
    CONSTRAINT pk_roomAmenities
		PRIMARY KEY (amenityId, roomId),
	CONSTRAINT fk_roomAmenities_room
		FOREIGN KEY (roomId)
        REFERENCES room(roomId),
	CONSTRAINT fk_roomAmenities_amenityDetails
		FOREIGN KEY (amenityId)
        REFERENCES amenityDetails(amenityId)
);

-- address_details table, addressId PK
CREATE TABLE addressDetails(
 addressId int NOT NULL AUTO_INCREMENT,
 address VARCHAR(256),
    city VARCHAR(100),
    stateAbbr CHAR(2),
    zip CHAR(5),
    CONSTRAINT pk_addressDetails
		PRIMARY KEY (addressId)
        );

-- guest table , guestId PK , addressId FK
-- guest(M) -- (1)address_details
CREATE TABLE guest (
	guestId INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    addressId INT NOT NULL,
    phone VARCHAR(14),
    CONSTRAINT pk_guest
		PRIMARY KEY (guestId),
	CONSTRAINT fk_guest_addressDetails
		FOREIGN KEY (addressId)
		REFERENCES addressDetails(addressId)
    );
    
    
-- reservationDetails table, reservationId PK
CREATE TABLE reservationDetails (
	reservationId INT NOT NULL AUTO_INCREMENT,
    startDate DATE NOT NULL, 
    endDate DATE NOT NULL,
    guestId INT NOT NULL,
    quantityAdults INT NOT NULL,
    quantityChildren INT NOT NULL,
    CONSTRAINT pk_reservationDetails
		PRIMARY KEY (reservationId),
	CONSTRAINT fk_reservationDetails_guestId
        FOREIGN KEY (guestId)
        REFERENCES guest(guestId)
);

-- roomsReserved table, composite PK (reservationId, roomId),
-- roomsReserved (M) -- (1) reservationDetails
CREATE TABLE roomsReserved (
	roomId INT NOT NULL,
    reservationId INT NOT NULL,
    CONSTRAINT pk_roomsReserved
		PRIMARY KEY (roomId, reservationId),
	CONSTRAINT fk_roomsReserved_room
		FOREIGN KEY (roomId)
        REFERENCES room(roomId),
	CONSTRAINT fk_roomsReserved_reservationDetails
		FOREIGN KEY (reservationId)
        REFERENCES reservationDetails(reservationId)
);



