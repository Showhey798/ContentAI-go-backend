package configs

// Config holds application configuration
type Config struct {
	Server ServerConfig
	DB     DBConfig
}

// ServerConfig holds server related configuration
type ServerConfig struct {
	Port    string
	Timeout int // in seconds
}

// DBConfig holds database related configuration
type DBConfig struct {
	Host     string
	Port     string
	User     string
	Password string
	DBName   string
}

// DefaultConfig returns default configuration
func DefaultConfig() Config {
	return Config{
		Server: ServerConfig{
			Port:    "8080",
			Timeout: 30,
		},
		DB: DBConfig{
			Host:     "localhost",
			Port:     "5432",
			User:     "postgres",
			Password: "password",
			DBName:   "contentai",
		},
	}
}
