package recommendation

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetRecommendations(t *testing.T) {
	// Setup
	service := NewService()

	// Execute
	recommendations, err := service.GetRecommendations("user123")

	// Verify
	assert.NoError(t, err)
	assert.NotEmpty(t, recommendations)
	assert.Equal(t, "1", recommendations[0].ID)
	assert.Equal(t, "Getting Started with ContentAI", recommendations[0].Title)
}
