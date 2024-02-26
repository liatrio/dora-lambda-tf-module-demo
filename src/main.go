package main

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

type MyResponse struct {
	Timestamp string `json:"timestamp"`
}

type APIGatewayProxyResponse struct {
	StatusCode int               `json:"statusCode"`
	Headers    map[string]string `json:"headers"`
	Body       string            `json:"body"`
}

func HandleRequest(ctx context.Context) (*APIGatewayProxyResponse, error) {
	resp := &MyResponse{Timestamp: fmt.Sprintf("%d", time.Now().Unix())}
	body, _ := json.Marshal(resp)
	return &APIGatewayProxyResponse{
		StatusCode: 200,
		Headers:    map[string]string{"Content-Type": "application/json"},
		Body:       string(body),
	}, nil
}

func main() {
	lambda.Start(HandleRequest)
}
