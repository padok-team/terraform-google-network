package test

import (
	"flag"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

var destroy = flag.Bool("destroy", false, "destroy the infrastructure after testing")

func TestTerraformHelloWorldExample(t *testing.T) {
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/gke",
		// VarFiles: []string{"tests/tests.tfvars"},
	})

	if *destroy {
		defer terraform.Destroy(t, terraformOptions)
	}

	terraform.InitAndApply(t, terraformOptions)

	// network_id := terraform.Output(t, terraformOptions, "network_id")
	// assert.Equal(t, "projects/padok-library-gcp-host/global/networks/testing", network_id)

	// network_name := terraform.Output(t, terraformOptions, "network_name")
	// assert.Equal(t, "testing", network_name)

	// network_self_link := terraform.Output(t, terraformOptions, "network_self_link")
	// assert.Equal(t, "https://www.googleapis.com/compute/v1/projects/padok-library-gcp-host/global/networks/testing", network_self_link)
}
