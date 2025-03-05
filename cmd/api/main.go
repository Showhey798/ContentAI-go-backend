package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/health", healthCheck)
	r.GET("/api/v1/version", getVersion)

	log.Println("Starting server on :8080")
	if err := r.Run(":8080"); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}

// healthCheck handles the health check endpoint
func healthCheck(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"status": "ok",
	})
}

// getVersion returns the API version information
func getVersion(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"version": "0.1.0",
		"name":    "ContentAI API",
	})
}
