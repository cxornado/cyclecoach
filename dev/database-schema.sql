-- CycleCoach Development Database Schema
-- Database: cyclecoach_dev
-- Host: mysql.cyclecoach.site
-- User: cyclecoachsql

-- Drop existing tables if they exist (for development)
DROP TABLE IF EXISTS user_sessions;
DROP TABLE IF EXISTS user_goals;
DROP TABLE IF EXISTS training_plans;
DROP TABLE IF EXISTS ride_data;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS third_party_connections;
DROP TABLE IF EXISTS ai_models;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    weight_kg DECIMAL(5,2),
    height_cm INT,
    fitness_level ENUM('beginner', 'intermediate', 'advanced', 'elite') DEFAULT 'beginner',
    cycling_experience_years INT DEFAULT 0,
    preferred_cycling_type ENUM('road', 'mountain', 'gravel', 'indoor', 'mixed') DEFAULT 'road',
    max_heart_rate INT,
    ftp_watts INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    last_login TIMESTAMP NULL,
    INDEX idx_email (email),
    INDEX idx_username (username),
    INDEX idx_active (is_active)
);

-- Create equipment table
CREATE TABLE equipment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    equipment_type ENUM('bike', 'trainer', 'power_meter', 'heart_rate_monitor', 'gps_device', 'sensor') NOT NULL,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    model VARCHAR(50),
    specifications JSON,
    is_primary BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_equipment (user_id, equipment_type),
    INDEX idx_active_equipment (is_active)
);

-- Create third_party_connections table
CREATE TABLE third_party_connections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    service_name ENUM('strava', 'garmin', 'zwift', 'training_peaks', 'garmin_connect') NOT NULL,
    access_token VARCHAR(500),
    refresh_token VARCHAR(500),
    token_expires_at TIMESTAMP NULL,
    user_service_id VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    last_sync_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_service (user_id, service_name),
    INDEX idx_active_connections (is_active),
    INDEX idx_service_user (service_name, user_id)
);

-- Create ride_data table
CREATE TABLE ride_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    ride_date DATE NOT NULL,
    ride_time TIMESTAMP NOT NULL,
    duration_seconds INT NOT NULL,
    distance_meters DECIMAL(10,2),
    elevation_gain_meters INT,
    average_speed_kmh DECIMAL(5,2),
    max_speed_kmh DECIMAL(5,2),
    average_heart_rate INT,
    max_heart_rate INT,
    average_power_watts INT,
    max_power_watts INT,
    ftp_percentage DECIMAL(5,2),
    calories_burned INT,
    weather_conditions JSON,
    route_data JSON,
    power_data JSON,
    heart_rate_data JSON,
    cadence_data JSON,
    source_service ENUM('strava', 'garmin', 'zwift', 'manual', 'cyclecoach') DEFAULT 'manual',
    source_activity_id VARCHAR(100),
    is_processed BOOLEAN DEFAULT FALSE,
    ai_analysis_score DECIMAL(3,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_rides (user_id, ride_date),
    INDEX idx_ride_date (ride_date),
    INDEX idx_source_service (source_service),
    INDEX idx_processed (is_processed)
);

-- Create training_plans table
CREATE TABLE training_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_name VARCHAR(100) NOT NULL,
    plan_type ENUM('base_building', 'threshold', 'vo2_max', 'endurance', 'recovery', 'custom') NOT NULL,
    target_event VARCHAR(100),
    target_date DATE,
    duration_weeks INT NOT NULL,
    difficulty_level ENUM('easy', 'moderate', 'hard', 'very_hard') DEFAULT 'moderate',
    total_volume_hours DECIMAL(5,2),
    total_distance_km DECIMAL(8,2),
    plan_description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    is_completed BOOLEAN DEFAULT FALSE,
    completion_percentage DECIMAL(5,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_plans (user_id, is_active),
    INDEX idx_plan_type (plan_type),
    INDEX idx_active_plans (is_active)
);

-- Create user_goals table
CREATE TABLE user_goals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    goal_type ENUM('distance', 'time', 'power', 'weight_loss', 'event', 'custom') NOT NULL,
    goal_name VARCHAR(100) NOT NULL,
    target_value DECIMAL(10,2),
    target_unit VARCHAR(20),
    target_date DATE,
    current_value DECIMAL(10,2) DEFAULT 0,
    progress_percentage DECIMAL(5,2) DEFAULT 0,
    is_achieved BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_goals (user_id, is_active),
    INDEX idx_goal_type (goal_type),
    INDEX idx_active_goals (is_active)
);

-- Create ai_models table
CREATE TABLE ai_models (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    model_type ENUM('training_recommendation', 'power_prediction', 'injury_prevention', 'performance_analysis') NOT NULL,
    version VARCHAR(20) NOT NULL,
    model_parameters JSON,
    accuracy_score DECIMAL(5,4),
    is_active BOOLEAN DEFAULT TRUE,
    is_production BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_model_type (model_type),
    INDEX idx_active_models (is_active),
    INDEX idx_production_models (is_production)
);

-- Create user_sessions table
CREATE TABLE user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    session_token VARCHAR(255) UNIQUE NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    expires_at TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_session_token (session_token),
    INDEX idx_user_sessions (user_id),
    INDEX idx_active_sessions (is_active),
    INDEX idx_expires_at (expires_at)
);

-- Insert sample development data
INSERT INTO users (username, email, password_hash, first_name, last_name, fitness_level, cycling_experience_years, preferred_cycling_type, ftp_watts, max_heart_rate) VALUES
('test_user', 'test@cyclecoach.site', '$2y$10$example_hash', 'Test', 'User', 'intermediate', 3, 'road', 250, 185),
('dev_admin', 'admin@cyclecoach.site', '$2y$10$example_hash', 'Development', 'Admin', 'advanced', 5, 'mixed', 300, 190);

INSERT INTO equipment (user_id, equipment_type, name, brand, model, is_primary) VALUES
(1, 'bike', 'Road Bike', 'Trek', 'Emonda SLR', TRUE),
(1, 'power_meter', 'Power Meter', 'Garmin', 'Vector 3', TRUE),
(1, 'heart_rate_monitor', 'HR Monitor', 'Garmin', 'HRM-Pro', TRUE),
(2, 'bike', 'Mountain Bike', 'Specialized', 'Stumpjumper', TRUE);

INSERT INTO third_party_connections (user_id, service_name, access_token, user_service_id, is_active) VALUES
(1, 'strava', 'sample_strava_token', 'strava_user_123', TRUE),
(1, 'garmin', 'sample_garmin_token', 'garmin_user_456', TRUE),
(2, 'zwift', 'sample_zwift_token', 'zwift_user_789', TRUE);

INSERT INTO ride_data (user_id, ride_date, ride_time, duration_seconds, distance_meters, elevation_gain_meters, average_speed_kmh, max_speed_kmh, average_heart_rate, max_heart_rate, average_power_watts, max_power_watts, source_service) VALUES
(1, '2025-01-15', '2025-01-15 08:00:00', 3600, 25000, 150, 25.0, 45.0, 145, 175, 200, 350, 'strava'),
(1, '2025-01-17', '2025-01-17 07:30:00', 2700, 18000, 100, 24.0, 42.0, 140, 170, 190, 320, 'garmin'),
(2, '2025-01-16', '2025-01-16 18:00:00', 1800, 12000, 50, 24.0, 40.0, 135, 165, 180, 300, 'zwift');

INSERT INTO training_plans (user_id, plan_name, plan_type, target_event, target_date, duration_weeks, difficulty_level, total_volume_hours, total_distance_km) VALUES
(1, 'Base Building Plan', 'base_building', 'Spring Training', '2025-04-01', 8, 'moderate', 40.5, 800.0),
(2, 'Threshold Training', 'threshold', 'Local Race', '2025-03-15', 6, 'hard', 35.0, 600.0);

INSERT INTO user_goals (user_id, goal_type, goal_name, target_value, target_unit, target_date, current_value, progress_percentage) VALUES
(1, 'distance', 'Monthly Distance Goal', 500.0, 'km', '2025-02-01', 250.0, 50.0),
(1, 'power', 'FTP Improvement', 275.0, 'watts', '2025-03-01', 250.0, 90.9),
(2, 'event', 'Complete Century Ride', 160.0, 'km', '2025-06-01', 0.0, 0.0);

INSERT INTO ai_models (model_name, model_type, version, accuracy_score, is_active, is_production) VALUES
('training_recommendation_v1', 'training_recommendation', '1.0.0', 0.85, TRUE, FALSE),
('power_prediction_v1', 'power_prediction', '1.0.0', 0.92, TRUE, FALSE),
('injury_prevention_v1', 'injury_prevention', '1.0.0', 0.78, TRUE, FALSE);

-- Create indexes for better performance
CREATE INDEX idx_ride_data_user_date ON ride_data(user_id, ride_date);
CREATE INDEX idx_training_plans_user_active ON training_plans(user_id, is_active);
CREATE INDEX idx_user_goals_progress ON user_goals(user_id, progress_percentage);
CREATE INDEX idx_third_party_user_service ON third_party_connections(user_id, service_name);

-- Add comments for documentation
COMMENT ON TABLE users IS 'Main user accounts for CycleCoach platform';
COMMENT ON TABLE equipment IS 'User equipment and devices for tracking';
COMMENT ON TABLE third_party_connections IS 'Connections to external services like Strava, Garmin, Zwift';
COMMENT ON TABLE ride_data IS 'Individual ride/activity data from various sources';
COMMENT ON TABLE training_plans IS 'AI-generated and custom training plans';
COMMENT ON TABLE user_goals IS 'User-defined goals and progress tracking';
COMMENT ON TABLE ai_models IS 'Machine learning models for coaching features';
COMMENT ON TABLE user_sessions IS 'User authentication sessions and security'; 