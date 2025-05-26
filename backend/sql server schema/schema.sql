CREATE TABLE [User] (
  [id] INT IDENTITY(1,1) PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  [email] NVARCHAR(255) NOT NULL UNIQUE,
  [password] NVARCHAR(255) NOT NULL
);

INSERT INTO [User] ([name], [email], [password]) VALUES ('Mohamed', 'Mohamed', '1');

CREATE TABLE [Category] (
  [id] INT IDENTITY(1,1) PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL
);

CREATE TABLE [Show] (
  [id] INT IDENTITY(1,1) PRIMARY KEY,
  [name] NVARCHAR(255) NOT NULL,
  [description] NVARCHAR(255) NOT NULL,
  [rating] INT NOT NULL,
  [time] NVARCHAR(255) NOT NULL,
  [age_limit] INT NOT NULL,
  [category] NVARCHAR(255) NOT NULL,
  [image] NVARCHAR(255) NOT NULL,
  [category_id] INT NOT NULL,
  FOREIGN KEY ([category_id]) REFERENCES [Category]([id]) ON DELETE CASCADE
);

CREATE TABLE [watch_later] (
  [id] INT IDENTITY(1,1) PRIMARY KEY,
  [user_id] INT NOT NULL,
  [show_id] INT NOT NULL,
  FOREIGN KEY ([user_id]) REFERENCES [User]([id]) ON DELETE CASCADE,
  FOREIGN KEY ([show_id]) REFERENCES [Show]([id]) ON DELETE CASCADE
);

-- Optional: Create Comments Table
CREATE TABLE [Comments] (
  [id] INT IDENTITY(1,1) PRIMARY KEY,
  [comment] NVARCHAR(255) NOT NULL,
  [user_id] INT NOT NULL,
  [show_id] INT NOT NULL,
  FOREIGN KEY ([user_id]) REFERENCES [User]([id]) ON DELETE CASCADE,
  FOREIGN KEY ([show_id]) REFERENCES [Show]([id]) ON DELETE CASCADE
);
