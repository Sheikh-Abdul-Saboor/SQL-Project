-- Create Database
CREATE DATABASE FreelancePlatformDB;
USE FreelancePlatformDB;
-- Tables
-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    Status VARCHAR(50)
);

-- Contract Table
CREATE TABLE Contract (
    ContractId INT PRIMARY KEY AUTO_INCREMENT,
    StartDate DATE,
    EndDate DATE,
    AgreedAmount DECIMAL(10,2),
    DeliverableLinks TEXT,
    PaymentID INT,
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);

-- Message Table
CREATE TABLE Message (
    MessageId INT PRIMARY KEY AUTO_INCREMENT,
    TimeStamp DATETIME,
    Content TEXT,
    SenderId INT,
    ReceiverId INT
);

-- Bid Table
CREATE TABLE Bid (
    BidId INT PRIMARY KEY AUTO_INCREMENT,
    BidAmount DECIMAL(10,2),
    DeliveryTime VARCHAR(50),
    ProposalDescription TEXT,
    BidDate DATE,
    Status VARCHAR(50),
    ContractId INT,
    FOREIGN KEY (ContractId) REFERENCES Contract(ContractId)
);

-- Project Table
CREATE TABLE Project (
    ProjectId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    Description TEXT,
    Budget DECIMAL(10,2),
    Deadline DATE,
    Status VARCHAR(50),
    CreatedDate DATE,
    BidId INT,
    FOREIGN KEY (BidId) REFERENCES Bid(BidId)
);

-- Freelancer Table
CREATE TABLE Freelancer (
    FreelancerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20),
    Skill VARCHAR(100),
    Experience VARCHAR(50),
    Rating DECIMAL(3,2),
    ProfileDescription TEXT,
    PortfolioLink VARCHAR(255),
    ContractId INT,
    MessageId INT,
    FOREIGN KEY (ContractId) REFERENCES Contract(ContractId),
    FOREIGN KEY (MessageId) REFERENCES Message(MessageId)
);

-- Client Table
CREATE TABLE Client (
    ClientID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    CompanyName VARCHAR(100),
    Phone VARCHAR(20),
    Rating DECIMAL(3,2),
    ProfileDescription TEXT,
    ProjectId INT,
    MessageId INT,
    FOREIGN KEY (ProjectId) REFERENCES Project(ProjectId),
    FOREIGN KEY (MessageId) REFERENCES Message(MessageId)
);

-- Freelancer Email Table
CREATE TABLE Freelancer_Email (
    Email VARCHAR(100) PRIMARY KEY,
    FreelancerID INT,
    FOREIGN KEY (FreelancerID) REFERENCES Freelancer(FreelancerID)
);

-- Client Email Table
CREATE TABLE Client_Email (
    Email VARCHAR(100) PRIMARY KEY,
    ClientID INT,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

-- Contract Payment Status Table
CREATE TABLE Contract_Payment_Status (
    PaymentStatus VARCHAR(50),
    ContractId INT,
    FOREIGN KEY (ContractId) REFERENCES Contract(ContractId)
);

-- Payment Method Table
CREATE TABLE Payment_Payment_Method (
    PaymentMethod VARCHAR(50),
    PaymentID INT,
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);

-- Freelancer Bids Relation (Many-to-Many between Freelancer and Bid)
CREATE TABLE Freelancer_Bids (
    FreelancerID INT,
    BidId INT,
    PRIMARY KEY (FreelancerID, BidId),
    FOREIGN KEY (FreelancerID) REFERENCES Freelancer(FreelancerID),
    FOREIGN KEY (BidId) REFERENCES Bid(BidId)
);

-- **********************************************************
-- Insert Dummy Data
-- **********************************************************
INSERT INTO Payment (PaymentDate, Amount, Status) VALUES
('2025-06-01', 500.00, 'Completed'),
('2025-06-02', 1000.00, 'Pending'),
('2025-06-03', 750.00, 'Completed'),
('2025-06-04', 1200.00, 'Failed'),
('2025-06-05', 300.00, 'Completed');

INSERT INTO Contract (StartDate, EndDate, AgreedAmount, DeliverableLinks, PaymentID) VALUES
('2025-06-01', '2025-06-10', 500.00, 'link1.com', 1),
('2025-06-02', '2025-06-15', 1000.00, 'link2.com', 2),
('2025-06-03', '2025-06-12', 750.00, 'link3.com', 3),
('2025-06-04', '2025-06-20', 1200.00, 'link4.com', 4),
('2025-06-05', '2025-06-25', 300.00, 'link5.com', 5);

INSERT INTO Message (TimeStamp, Content, SenderId, ReceiverId) VALUES
(NOW(), 'Hello, I want to work on your project.', 1, 101),
(NOW(), 'Please share more details.', 101, 1),
(NOW(), 'I have submitted the proposal.', 2, 102),
(NOW(), 'Can you reduce the price?', 102, 2),
(NOW(), 'Deadline is very close, please hurry.', 3, 103);

INSERT INTO Bid (BidAmount, DeliveryTime, ProposalDescription, BidDate, Status, ContractId) VALUES
(450.00, '5 days', 'Experienced in web dev.', '2025-06-01', 'Accepted', 1),
(950.00, '10 days', 'Can deliver fast.', '2025-06-02', 'Pending', 2),
(700.00, '7 days', 'Specialist in backend.', '2025-06-03', 'Rejected', 3),
(1150.00, '12 days', 'Full-stack solution.', '2025-06-04', 'Accepted', 4),
(280.00, '3 days', 'Quick delivery.', '2025-06-05', 'Pending', 5);

INSERT INTO Project (Title, Description, Budget, Deadline, Status, CreatedDate, BidId) VALUES
('Website Development', 'Build an ecommerce site.', 500.00, '2025-06-15', 'Open', '2025-06-01', 1),
('Mobile App', 'Develop a food delivery app.', 1000.00, '2025-06-20', 'In Progress', '2025-06-02', 2),
('Data Analysis', 'Analyze sales data.', 750.00, '2025-06-18', 'Completed', '2025-06-03', 3),
('Branding Design', 'Create marketing assets.', 1200.00, '2025-06-25', 'Open', '2025-06-04', 4),
('SEO Optimization', 'Improve site SEO.', 300.00, '2025-06-12', 'Pending', '2025-06-05', 5);

INSERT INTO Freelancer (Name, Password, PhoneNumber, Skill, Experience, Rating, ProfileDescription, PortfolioLink, ContractId, MessageId) VALUES
('Ali Khan', 'pass123', '1234567890', 'Web Development', '3 years', 4.5, 'Full stack developer.', 'ali.com', 1, 1),
('Sara Ahmed', 'pass456', '9876543210', 'Mobile Apps', '5 years', 4.8, 'Expert in Flutter.', 'sara.com', 2, 2),
('Usman Tariq', 'pass789', '5678901234', 'Data Science', '2 years', 4.2, 'Machine learning projects.', 'usman.com', 3, 3),
('Hina Riaz', 'pass101', '4567890123', 'Graphic Design', '4 years', 4.6, 'Creative designer.', 'hina.com', 4, 4),
('Bilal Shah', 'pass202', '3456789012', 'SEO', '1 year', 4.1, 'SEO optimization expert.', 'bilal.com', 5, 5);

INSERT INTO Client (Name, Password, CompanyName, Phone, Rating, ProfileDescription, ProjectId, MessageId) VALUES
('John Doe', 'client123', 'TechCorp', '111222333', 4.7, 'Looking for IT freelancers.', 1, 1),
('Emily Smith', 'client456', 'AppWorld', '222333444', 4.5, 'Focus on app development.', 2, 2),
('David Lee', 'client789', 'DataWorks', '333444555', 4.6, 'Data analytics projects.', 3, 3),
('Sophia Brown', 'client101', 'Brandify', '444555666', 4.8, 'Creative branding.', 4, 4),
('Michael Scott', 'client202', 'SEOHub', '555666777', 4.3, 'SEO consultancy.', 5, 5);

INSERT INTO Freelancer_Email VALUES
('ali@example.com', 1),
('sara@example.com', 2),
('usman@example.com', 3),
('hina@example.com', 4),
('bilal@example.com', 5);

INSERT INTO Client_Email VALUES
('john@example.com', 1),
('emily@example.com', 2),
('david@example.com', 3),
('sophia@example.com', 4),
('michael@example.com', 5);

INSERT INTO Contract_Payment_Status VALUES
('Completed', 1),
('Pending', 2),
('Completed', 3),
('Failed', 4),
('Completed', 5);

INSERT INTO Payment_Payment_Method VALUES
('Credit Card', 1),
('PayPal', 2),
('Bank Transfer', 3),
('Stripe', 4),
('Payoneer', 5);

INSERT INTO Freelancer_Bids VALUES
(1,1), (2,2), (3,3), (4,4), (5,5);

-- **********************************************************
-- Joins Examples
-- **********************************************************

-- INNER JOIN (Freelancer and Contract)
SELECT f.Name, f.Skill, c.AgreedAmount
FROM Freelancer f
INNER JOIN Contract c ON f.ContractId = c.ContractId;

-- LEFT JOIN (Project and Bid)
SELECT p.Title, b.BidAmount, b.Status
FROM Project p
LEFT JOIN Bid b ON p.BidId = b.BidId;

-- RIGHT JOIN (Client and Project)
SELECT cl.Name AS ClientName, pr.Title
FROM Client cl
RIGHT JOIN Project pr ON cl.ProjectId = pr.ProjectId;

-- FULL OUTER JOIN (Project and Freelancer_Bids)
SELECT p.ProjectId, p.Title, fb.FreelancerID
FROM Project p
LEFT JOIN Freelancer_Bids fb ON p.BidId = fb.BidId
UNION
SELECT p.ProjectId, p.Title, fb.FreelancerID
FROM Project p
RIGHT JOIN Freelancer_Bids fb ON p.BidId = fb.BidId;

-- SELF JOIN (Freelancers with same skill)
SELECT f1.Name AS Freelancer1, f2.Name AS Freelancer2, f1.Skill
FROM Freelancer f1
JOIN Freelancer f2 ON f1.Skill = f2.Skill AND f1.FreelancerID <> f2.FreelancerID;

-- **********************************************************
-- Operators
-- **********************************************************
-- LIKE
SELECT * FROM Project WHERE Title LIKE '%App%';

-- IN
SELECT * FROM Bid WHERE Status IN ('Accepted','Pending');

-- NOT IN
SELECT * FROM Contract WHERE ContractId NOT IN (1,3);

-- BETWEEN
SELECT * FROM Payment WHERE PaymentDate BETWEEN '2025-06-01' AND '2025-06-03';

-- IS NULL
SELECT * FROM Freelancer WHERE PhoneNumber IS NULL;

-- **********************************************************
-- Aggregates
-- **********************************************************
-- SUM
SELECT SUM(Amount) AS TotalPayments FROM Payment;

-- AVG
SELECT AVG(Rating) AS AvgFreelancerRating FROM Freelancer;

-- MAX
SELECT MAX(Deadline) AS LatestDeadline FROM Project;

-- MIN
SELECT MIN(Amount) AS SmallestPayment FROM Payment;

-- COUNT
SELECT COUNT(*) AS TotalProjects FROM Project;
