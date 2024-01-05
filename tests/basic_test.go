package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestBasic(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/basic",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// enabler-github-app:custom-code-block:start
	// test your code below

	// network_id := terraform.Output(t, terraformOptions, "network_id")
	// assert.Equal(t, "projects/padok-library-gcp-host/global/networks/testing", network_id)

	// network_name := terraform.Output(t, terraformOptions, "network_name")
	// assert.Equal(t, "testing", network_name)

	// enabler-github-app:custom-code-block:end
}
