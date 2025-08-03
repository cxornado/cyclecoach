# CycleCoach Development Environment

Secure backend development environment for building the AI-powered cycling coach platform.

## 🚀 Quick Access

- **Development Dashboard**: `/dev/` (this page)
- **Public Site**: `/` (main landing page)
- **Database**: `mysql.cyclecoach.site`

## 🔧 Development Features

### **Admin Dashboard**
- User management and analytics
- System monitoring and logs
- Performance metrics tracking
- Development tools and utilities

### **Database Management**
- Direct MySQL access for development
- Schema management and testing
- Sample data for development
- Database backup and restore

### **API Development**
- REST API endpoints for authentication
- Third-party service integration
- AI coaching features
- Data synchronization

### **AI Training**
- Machine learning model development
- Training data management
- Model validation and testing
- Performance analysis

## 📊 Database Schema

### **Core Tables:**
- `users` - User accounts and profiles
- `equipment` - User bikes and devices
- `third_party_connections` - Strava, Garmin, Zwift integration
- `ride_data` - Activity and performance data
- `training_plans` - AI-generated training programs
- `user_goals` - Goal tracking and progress
- `ai_models` - Machine learning models
- `user_sessions` - Authentication and security

### **Sample Data:**
- Test users with realistic profiles
- Sample ride data from various sources
- Training plans and goals
- AI model configurations

## 🔐 Security Features

### **Access Control:**
- Development-only access
- Secure authentication
- Session management
- IP restrictions (configurable)

### **Data Protection:**
- Encrypted connections
- Secure token storage
- Privacy compliance
- GDPR-ready features

## 🛠️ Development Workflow

### **1. Database Setup**
```sql
-- Connect to MySQL
mysql -h mysql.cyclecoach.site -u cyclecoachsql -p

-- Create development database
CREATE DATABASE cyclecoach_dev;
USE cyclecoach_dev;

-- Import schema
source dev/database-schema.sql;
```

### **2. API Development**
- RESTful endpoints for all features
- Authentication and authorization
- Third-party service integration
- Real-time data processing

### **3. AI Model Development**
- Training data collection
- Model training and validation
- Performance optimization
- Production deployment

## 📈 Development Roadmap

### **Phase 1: Core Infrastructure**
- ✅ Database schema design
- ✅ User authentication system
- ✅ Basic API endpoints
- ✅ Development environment setup

### **Phase 2: Data Integration**
- 🔄 Strava API integration
- 🔄 Garmin Connect integration
- 🔄 Zwift data synchronization
- 🔄 Real-time data processing

### **Phase 3: AI Features**
- 🔄 Training plan generation
- 🔄 Performance analysis
- 🔄 Goal tracking algorithms
- 🔄 Injury prevention models

### **Phase 4: Production Features**
- 🔄 User dashboard
- 🔄 Mobile app development
- 🔄 Advanced analytics
- 🔄 Community features

## 🔗 External Integrations

### **Supported Services:**
- **Strava** - Activity tracking and social features
- **Garmin Connect** - Device data and training
- **Zwift** - Indoor training and virtual racing
- **Training Peaks** - Advanced training planning

### **API Endpoints:**
- User authentication and management
- Activity data synchronization
- Training plan generation
- Performance analytics

## 📝 Development Notes

### **Environment Variables:**
```bash
DB_HOST=mysql.cyclecoach.site
DB_NAME=cyclecoach_dev
DB_USER=cyclecoachsql
DB_PASS=y#8Z6!yK#Paq5gpT
```

### **Security Considerations:**
- All passwords are hashed using bcrypt
- API tokens are encrypted
- Database connections use SSL
- Session tokens expire automatically

### **Performance Optimization:**
- Database indexes for common queries
- Caching for frequently accessed data
- Async processing for heavy operations
- CDN for static assets

## 🚨 Important Notes

### **Development Only:**
- This environment is for development only
- Do not use production data here
- Test with sample data only
- Regular backups recommended

### **Access Control:**
- IP restrictions may be applied
- VPN access recommended
- Two-factor authentication for admin
- Regular security audits

## 📞 Support

For development issues or questions:
- **Email**: dev@cyclecoach.site
- **Documentation**: `/dev/docs/`
- **API Reference**: `/dev/api/`
- **Database Schema**: `/dev/database-schema.sql`

---

**Last Updated**: January 2025  
**Version**: 1.0.0  
**Environment**: Development 