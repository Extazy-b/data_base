BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS Vac_Type(
    Type_id INTEGER NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Description TEXT,
    CONSTRAINT Vac_Type_PK PRIMARY KEY (Type_ID)
);

CREATE TABLE IF NOT EXISTS Vaccine(
    Type INTEGER NOT NULL,
    Date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Pet_id INTEGER NOT NULL,
    Proof_id INTEGER NOT NULL,
    CONSTRAINT FK_Pet_ID FOREIGN KEY (Pet_ID) REFERENCES Pet(Pet_ID),
    CONSTRAINT FK_Type FOREIGN KEY (Type) REFERENCES Vac_Type(Type_id)
);

INSERT INTO Vac_Type (Type_id, Name, Description) 
VALUES (1, 'Бешенство', '');

INSERT INTO Vac_Type (Type_id, Name, Description) 
VALUES (2, 'Чумка', '');

COMMIT;