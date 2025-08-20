-- Freelancer Table
CREATE TABLE Freelancer (
    FreelancerID INT PRIMARY KEY,
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
    ClientID INT PRIMARY KEY,
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

-- Project Table
CREATE TABLE Project (
    ProjectId INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Description TEXT,
    Budget DECIMAL(10,2),
    Deadline DATE,
    Status VARCHAR(50),
    CreatedDate DATE,
    BidId INT,
    FOREIGN KEY (BidId) REFERENCES Bid(BidId)
);

-- Bid Table
CREATE TABLE Bid (
    BidId INT PRIMARY KEY,
    BidAmount DECIMAL(10,2),
    DeliveryTime VARCHAR(50),
    ProposalDescription TEXT,
    BidDate DATE,
    Status VARCHAR(50),
    ContractId INT,
    FOREIGN KEY (ContractId) REFERENCES Contract(ContractId)
);

-- Contract Table
CREATE TABLE Contract (
    ContractId INT PRIMARY KEY,
    EndDate DATE,
    StartDate DATE,
    AgreedAmount DECIMAL(10,2),
    DeliverableLinks TEXT,
    PaymentID INT,
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);

-- Message Table
CREATE TABLE Message (
    MessageId INT PRIMARY KEY,
    TimeStamp DATETIME,
    Content TEXT,
    SenderId INT,
    ReceiverId INT
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    Status VARCHAR(50)
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
