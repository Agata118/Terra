terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

resource "null_resource" "create_hello_world_file" {
  provisioner "local-exec" {
    command = "echo 'public class HelloWorld { public static void main(String[] args) { System.out.println(\"${var.greeting}\"); } }' > HelloWorld.java"
  }
}

resource "null_resource" "copy_hello_world_file" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "copy HelloWorld.java test-terraform-workflow"
  }
}
