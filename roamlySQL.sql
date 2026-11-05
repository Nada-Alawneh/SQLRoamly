-- Tables Complete Schema for Roamly

CREATE TABLE Roles (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    created_at DATETIME NOT NULL
);

CREATE TABLE UserProfiles (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT UNIQUE NOT NULL,
    bio NVARCHAR(500),
    avatar_url VARCHAR(255)
);

CREATE TABLE Subscriptions (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    tier_name VARCHAR(50) UNIQUE NOT NULL,
    monthly_price DECIMAL(10,2) NOT NULL,
    max_trips INT
);

CREATE TABLE UserSubscriptions (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BIT NOT NULL
);

CREATE TABLE Currencies (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    code CHAR(3) UNIQUE NOT NULL,
    symbol NVARCHAR(10) NOT NULL
);

CREATE TABLE UserPreferences (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT UNIQUE NOT NULL,
    currency_id INT NOT NULL,
    dark_mode BIT NOT NULL
);

CREATE TABLE UserPaymentMethods (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    provider VARCHAR(50) NOT NULL,
    last_four CHAR(4) NOT NULL
);

CREATE TABLE UserDevices (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    device_token VARCHAR(255) UNIQUE NOT NULL,
    platform VARCHAR(20) NOT NULL
);

CREATE TABLE Trips (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    creator_id INT NOT NULL,
    title NVARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE TripMembers (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT NOT NULL,
    user_id INT NOT NULL,
    join_date DATETIME NOT NULL
);

CREATE TABLE Destinations (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    city NVARCHAR(100) NOT NULL,
    country NVARCHAR(100) NOT NULL,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);

CREATE TABLE TripDestinations (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT NOT NULL,
    dest_id INT NOT NULL,
    order_index INT NOT NULL
);

CREATE TABLE Itineraries (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT UNIQUE NOT NULL,
    is_ai_generated BIT NOT NULL
);

CREATE TABLE ItineraryDays (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    itinerary_id INT NOT NULL,
    day_date DATE NOT NULL
);

CREATE TABLE EventTypes (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL,
    icon VARCHAR(50)
);

CREATE TABLE ItineraryEvents (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    day_id INT NOT NULL,
    event_type_id INT NOT NULL,
    title NVARCHAR(100) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

CREATE TABLE Accommodations (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    dest_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    address NVARCHAR(255)
);

CREATE TABLE RoomTypes (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE TripAccommodations (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT NOT NULL,
    acc_id INT NOT NULL,
    room_type_id INT NOT NULL,
    check_in DATETIME NOT NULL,
    check_out DATETIME NOT NULL
);

CREATE TABLE TransportTypes (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Transports (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    transport_type_id INT NOT NULL,
    company_name NVARCHAR(100) NOT NULL
);

CREATE TABLE TripTransports (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT NOT NULL,
    transport_id INT NOT NULL,
    departure_time DATETIME NOT NULL
);

CREATE TABLE Flights (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT NOT NULL,
    airline VARCHAR(100) NOT NULL,
    flight_number VARCHAR(20) NOT NULL,
    departure_airport CHAR(3) NOT NULL
);

CREATE TABLE Budgets (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT UNIQUE NOT NULL,
    currency_id INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL
);

CREATE TABLE BudgetCategories (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE TripBudgetCategories (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    budget_id INT NOT NULL,
    category_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE Expenses (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT NOT NULL,
    paid_by_user_id INT NOT NULL,
    category_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    description NVARCHAR(255) NOT NULL
);

CREATE TABLE ExpenseSplits (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    expense_id INT NOT NULL,
    owed_by_user_id INT NOT NULL,
    amount_owed DECIMAL(10,2) NOT NULL,
    is_settled BIT NOT NULL
);

CREATE TABLE ExchangeRates (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    base_currency_id INT NOT NULL,
    target_currency_id INT NOT NULL,
    rate DECIMAL(10,6) NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE Invoices (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE Payments (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    invoice_id INT NOT NULL,
    method_id INT NOT NULL,
    payment_date DATETIME NOT NULL
);

CREATE TABLE AIPromptHistory (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    prompt_text NVARCHAR(MAX) NOT NULL,
    response_text NVARCHAR(MAX) NOT NULL
);

CREATE TABLE AIRecommendations (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    dest_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    content NVARCHAR(MAX) NOT NULL
);

CREATE TABLE AITripTemplates (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    dest_id INT NOT NULL,
    title NVARCHAR(100) NOT NULL,
    days_count INT NOT NULL
);

CREATE TABLE TripReviews (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    trip_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment NVARCHAR(500)
);

CREATE TABLE DestinationReviews (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    dest_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment NVARCHAR(500)
);

CREATE TABLE NotificationTypes (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Notifications (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    type_id INT NOT NULL,
    message NVARCHAR(255) NOT NULL,
    is_read BIT NOT NULL
);

CREATE TABLE AuditLogs (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    action VARCHAR(50) NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    record_id INT NOT NULL,
    timestamp DATETIME NOT NULL
);

ALTER TABLE Users ADD CONSTRAINT FK_Users_Roles_0 FOREIGN KEY (role_id) REFERENCES Roles(id);
ALTER TABLE UserProfiles ADD CONSTRAINT FK_UserProfiles_Users_1 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE UserSubscriptions ADD CONSTRAINT FK_UserSubscriptions_Users_2 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE UserSubscriptions ADD CONSTRAINT FK_UserSubscriptions_Subscriptions_3 FOREIGN KEY (sub_id) REFERENCES Subscriptions(id);
ALTER TABLE UserPreferences ADD CONSTRAINT FK_UserPreferences_Users_4 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE UserPreferences ADD CONSTRAINT FK_UserPreferences_Currencies_5 FOREIGN KEY (currency_id) REFERENCES Currencies(id);
ALTER TABLE UserPaymentMethods ADD CONSTRAINT FK_UserPaymentMethods_Users_6 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE UserDevices ADD CONSTRAINT FK_UserDevices_Users_7 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Trips ADD CONSTRAINT FK_Trips_Users_8 FOREIGN KEY (creator_id) REFERENCES Users(id);
ALTER TABLE TripMembers ADD CONSTRAINT FK_TripMembers_Trips_9 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE TripMembers ADD CONSTRAINT FK_TripMembers_Users_10 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE TripDestinations ADD CONSTRAINT FK_TripDestinations_Trips_11 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE TripDestinations ADD CONSTRAINT FK_TripDestinations_Destinations_12 FOREIGN KEY (dest_id) REFERENCES Destinations(id);
ALTER TABLE Itineraries ADD CONSTRAINT FK_Itineraries_Trips_13 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE ItineraryDays ADD CONSTRAINT FK_ItineraryDays_Itineraries_14 FOREIGN KEY (itinerary_id) REFERENCES Itineraries(id);
ALTER TABLE ItineraryEvents ADD CONSTRAINT FK_ItineraryEvents_ItineraryDays_15 FOREIGN KEY (day_id) REFERENCES ItineraryDays(id);
ALTER TABLE ItineraryEvents ADD CONSTRAINT FK_ItineraryEvents_EventTypes_16 FOREIGN KEY (event_type_id) REFERENCES EventTypes(id);
ALTER TABLE Accommodations ADD CONSTRAINT FK_Accommodations_Destinations_17 FOREIGN KEY (dest_id) REFERENCES Destinations(id);
ALTER TABLE TripAccommodations ADD CONSTRAINT FK_TripAccommodations_Trips_18 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE TripAccommodations ADD CONSTRAINT FK_TripAccommodations_Accommodations_19 FOREIGN KEY (acc_id) REFERENCES Accommodations(id);
ALTER TABLE TripAccommodations ADD CONSTRAINT FK_TripAccommodations_RoomTypes_20 FOREIGN KEY (room_type_id) REFERENCES RoomTypes(id);
ALTER TABLE Transports ADD CONSTRAINT FK_Transports_TransportTypes_21 FOREIGN KEY (transport_type_id) REFERENCES TransportTypes(id);
ALTER TABLE TripTransports ADD CONSTRAINT FK_TripTransports_Trips_22 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE TripTransports ADD CONSTRAINT FK_TripTransports_Transports_23 FOREIGN KEY (transport_id) REFERENCES Transports(id);
ALTER TABLE Flights ADD CONSTRAINT FK_Flights_Trips_24 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE Budgets ADD CONSTRAINT FK_Budgets_Trips_25 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE Budgets ADD CONSTRAINT FK_Budgets_Currencies_26 FOREIGN KEY (currency_id) REFERENCES Currencies(id);
ALTER TABLE TripBudgetCategories ADD CONSTRAINT FK_TripBudgetCategories_Budgets_27 FOREIGN KEY (budget_id) REFERENCES Budgets(id);
ALTER TABLE TripBudgetCategories ADD CONSTRAINT FK_TripBudgetCategories_BudgetCategories_28 FOREIGN KEY (category_id) REFERENCES BudgetCategories(id);
ALTER TABLE Expenses ADD CONSTRAINT FK_Expenses_Trips_29 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE Expenses ADD CONSTRAINT FK_Expenses_Users_30 FOREIGN KEY (paid_by_user_id) REFERENCES Users(id);
ALTER TABLE Expenses ADD CONSTRAINT FK_Expenses_BudgetCategories_31 FOREIGN KEY (category_id) REFERENCES BudgetCategories(id);
ALTER TABLE ExpenseSplits ADD CONSTRAINT FK_ExpenseSplits_Expenses_32 FOREIGN KEY (expense_id) REFERENCES Expenses(id);
ALTER TABLE ExpenseSplits ADD CONSTRAINT FK_ExpenseSplits_Users_33 FOREIGN KEY (owed_by_user_id) REFERENCES Users(id);
ALTER TABLE ExchangeRates ADD CONSTRAINT FK_ExchangeRates_Currencies_34 FOREIGN KEY (base_currency_id) REFERENCES Currencies(id);
ALTER TABLE ExchangeRates ADD CONSTRAINT FK_ExchangeRates_Currencies_35 FOREIGN KEY (target_currency_id) REFERENCES Currencies(id);
ALTER TABLE Invoices ADD CONSTRAINT FK_Invoices_Users_36 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Payments ADD CONSTRAINT FK_Payments_Invoices_37 FOREIGN KEY (invoice_id) REFERENCES Invoices(id);
ALTER TABLE Payments ADD CONSTRAINT FK_Payments_UserPaymentMethods_38 FOREIGN KEY (method_id) REFERENCES UserPaymentMethods(id);
ALTER TABLE AIPromptHistory ADD CONSTRAINT FK_AIPromptHistory_Users_39 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE AIRecommendations ADD CONSTRAINT FK_AIRecommendations_Destinations_40 FOREIGN KEY (dest_id) REFERENCES Destinations(id);
ALTER TABLE AITripTemplates ADD CONSTRAINT FK_AITripTemplates_Destinations_41 FOREIGN KEY (dest_id) REFERENCES Destinations(id);
ALTER TABLE TripReviews ADD CONSTRAINT FK_TripReviews_Trips_42 FOREIGN KEY (trip_id) REFERENCES Trips(id);
ALTER TABLE TripReviews ADD CONSTRAINT FK_TripReviews_Users_43 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE DestinationReviews ADD CONSTRAINT FK_DestinationReviews_Destinations_44 FOREIGN KEY (dest_id) REFERENCES Destinations(id);
ALTER TABLE DestinationReviews ADD CONSTRAINT FK_DestinationReviews_Users_45 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Notifications ADD CONSTRAINT FK_Notifications_Users_46 FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Notifications ADD CONSTRAINT FK_Notifications_NotificationTypes_47 FOREIGN KEY (type_id) REFERENCES NotificationTypes(id);
ALTER TABLE AuditLogs ADD CONSTRAINT FK_AuditLogs_Users_48 FOREIGN KEY (user_id) REFERENCES Users(id);

-- ==================================================
-- DAY 02 TOPICS: JOINS, VIEWS, FUNCTIONS, SPs, TRIGGERS
-- ==================================================

-- 1. INNER & LEFT JOIN, GROUP BY (Calculate User Debt and Trip Count)
SELECT 
    u.username, 
    COUNT(DISTINCT tm.trip_id) AS ParticipatedTrips, 
    ISNULL(SUM(es.amount_owed), 0) AS TotalDebt
FROM Users u
INNER JOIN TripMembers tm ON u.id = tm.user_id
LEFT JOIN ExpenseSplits es ON u.id = es.owed_by_user_id AND es.is_settled = 0
GROUP BY u.username
HAVING COUNT(DISTINCT tm.trip_id) > 0;

go
-- 2. VIEW: Full Trip Itinerary Details
CREATE VIEW vw_TripFullDetails AS
SELECT 
    t.title AS TripTitle,
    d.city, d.country,
    id.day_date,
    ie.title AS EventTitle,
    ie.start_time
FROM Trips t
INNER JOIN TripDestinations td ON t.id = td.trip_id
INNER JOIN Destinations d ON td.dest_id = d.id
INNER JOIN Itineraries i ON t.id = i.trip_id
INNER JOIN ItineraryDays id ON i.id = id.itinerary_id
INNER JOIN ItineraryEvents ie ON id.id = ie.day_id;
go
-- 3. SUBQUERY: Find users who paid more than the average expense
SELECT username, email 
FROM Users 
WHERE id IN (
    SELECT paid_by_user_id 
    FROM Expenses 
    WHERE amount > (SELECT AVG(amount) FROM Expenses)
);
go
-- 4. FUNCTION: Get total budget allocation per category
CREATE FUNCTION fn_GetBudgetCategoryTotal (@TripID INT, @CatID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);
    SELECT @Total = tbc.amount
    FROM TripBudgetCategories tbc
    INNER JOIN Budgets b ON tbc.budget_id = b.id
    WHERE b.trip_id = @TripID AND tbc.category_id = @CatID;
    RETURN ISNULL(@Total, 0);
END;
go
-- 5. STORED PROCEDURE: Add User to Trip with Validation
CREATE PROCEDURE sp_JoinTrip
    @UserID INT,
    @TripID INT
AS
BEGIN
    IF EXISTS(SELECT 1 FROM TripMembers WHERE user_id = @UserID AND trip_id = @TripID)
    BEGIN
        PRINT 'User already in trip!';
        RETURN;
    END

    INSERT INTO TripMembers (trip_id, user_id, join_date)
    VALUES (@TripID, @UserID, GETDATE());
    
    INSERT INTO AuditLogs (user_id, action, table_name, record_id, timestamp)
    VALUES (@UserID, 'JOIN_TRIP', 'TripMembers', SCOPE_IDENTITY(), GETDATE());
END;
go
-- 6. TRIGGER: Auto-Log Expense Deletion (Audit Trail)
CREATE TRIGGER trg_AuditExpenseDelete
ON Expenses
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditLogs (user_id, action, table_name, record_id, timestamp)
    SELECT paid_by_user_id, 'DELETE_EXPENSE', 'Expenses', id, GETDATE()
    FROM deleted;
END;
