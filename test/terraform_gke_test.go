package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestGke(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/gke",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndPlan(t, terraformOptions)
}
