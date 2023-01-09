# Create instances
resource "aws_instance" "dev" {
    count = 2
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Prop = "Terraform"
        Name = "dev-${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
}

# Usando o parametro count podemos definir a quantidade de instancias que serão geradas
# podemos ter acesso a número da instancia atual sendo criada usando o parametro ${count.index}, nesse exemplo usamos para criar TAGS


# Create instances
resource "aws_instance" "dev4" {
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Prop = "Terraform"
        Name = "dev-4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
    depends_on = [
      aws_s3_bucket.dev4
    ]
}


# Create instances
resource "aws_instance" "dev5" {
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Prop = "Terraform"
        Name = "dev-5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
}

# Create instances
resource "aws_instance" "dev6" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Prop = "Terraform"
        Name = "dev-6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh-us-east-2.id}"]
    depends_on = [
      aws_dynamodb_table.dynamodb-homologacao
    ]
}

# Create instances
resource "aws_instance" "dev7" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Prop = "Terraform"
        Name = "dev-7"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh-us-east-2.id}"]
}