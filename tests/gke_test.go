package test

import (
	// "fmt"
	// "os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestGke(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/gke",
		// VarFiles: []string{"tests/tests.tfvars"},
	})

	if *destroy {
		defer terraform.Destroy(t, terraformOptions)
	}

	// // List folders in ../examples
	// folders, err := os.ReadDir("../examples")
	// if err != nil {
	// 	t.Fatal(err)
	// }

	// for _, folder := range folders {
	// 	if !folder.IsDir() {
	// 		continue
	// 	}
	// 	fmt.Println(folder.Name())
	// }

	terraform.InitAndApply(t, terraformOptions)

	// network_id := terraform.Output(t, terraformOptions, "network_id")
	// assert.Equal(t, "projects/padok-library-gcp-host/global/networks/testing", network_id)

	// network_name := terraform.Output(t, terraformOptions, "network_name")
	// assert.Equal(t, "testing", network_name)

	// network_self_link := terraform.Output(t, terraformOptions, "network_self_link")
	// assert.Equal(t, "https://www.googleapis.com/compute/v1/projects/padok-library-gcp-host/global/networks/testing", network_self_link)
}
