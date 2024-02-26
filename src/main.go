package main

import (
	"context"
	"fmt"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

type MyResponse struct {
	Timestamp string `json:"timestamp"`
}

func HandleRequest(ctx context.Context) (*MyResponse, error) {
	return &MyResponse{Timestamp: fmt.Sprintf("%d", time.Now().Unix())}, nil
}

func main() {
	lambda.Start(HandleRequest)
}
