CREATE TABLE Students (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    pass_word VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Experiments (
    experiment_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    duration INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    available_quantity INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Sensor (
    sensor_id INT PRIMARY KEY AUTO_INCREMENT,
    sensor_type ENUM('temperature', 'pressure', 'humidity') NOT NULL,
    description TEXT,
    location VARCHAR(100)
);


CREATE TABLE SensorData (
    data_id INT PRIMARY KEY AUTO_INCREMENT,
    sensor_id INT,
    experiment_id INT,
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    value DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (sensor_id) REFERENCES Sensor(sensor_id),
    FOREIGN KEY (experiment_id) REFERENCES Experiments(experiment_id)
);

CREATE TABLE Results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    experiment_id INT,
    user_id INT,
    observation TEXT,
    data_file_path VARCHAR(255),  
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (experiment_id) REFERENCES Experiments(experiment_id),
    FOREIGN KEY (user_id) REFERENCES students(user_id)
);

CREATE TABLE ExperimentSteps (
    step_id INT PRIMARY KEY AUTO_INCREMENT,
    experiment_id INT,
    step_number INT NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (experiment_id) REFERENCES Experiments(experiment_id)
);


CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,  
    experiment_id INT,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES students(user_id),
    FOREIGN KEY (experiment_id) REFERENCES Experiments(experiment_id)
);

CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES students(user_id)
);