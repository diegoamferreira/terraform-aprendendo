# terraform-aprendendo
Aprendendo o básico do terraform (*ALURA*)

## Conceito
Com Terraform podemos gerenciar nossa infraestrutura usando código, funciona com uma grande quantidade de providers como por exemplo, AWS, AZURE, GCP... Lista com todos os provider pode ser encontrada no [Site Oficial](https://registry.terraform.io/browse/providers), subir ou deleter instancias com codigo de maneira abstrata.


## Iniciamos o documento definindo o Provider
```
    # Configure the AWS Provider
    provider "aws" {
        region = "us-east-1"
    }
```

## Criando um conjunto de instancia
Cria um conjunto de instancia baseado na imagem passada através do parametro ami, 

```
resource "aws_instance" "dev" {
    count = 2
    ami = "ami-06878d265978313ca"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Prop = "Terraform"
        Name = "dev-${count.index}"
    }
}
```

## Criando Security Group
```
resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "acesso_ssh"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["x"]
  }

  tags = {
    Prop = "Terraform"
    Name = "ssh"
  }
}
```

## Utilizando referencia entre recursos

```
# Create instances
resource "aws_instance" "dev" {
    count = 2
    ami = "ami-06878d265978313ca"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Prop = "Terraform"
        Name = "dev-${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
}
```

## Dependencia entre recursos
```
    depends_on = [
      aws_s3_bucket.dev4
    ]
```

## Trablando com variáveis

### Criando variaveis do tipo map
```
variable "amis" {
  type = map
  
  default = {
    "us-east-1" = "ami-06878d265978313ca"
    "us-east-2" = "ami-0a606d8395a538502"
  }
}
```
### Acessando variaveis do tipo map
```
# Create instances
resource "aws_instance" "dev5" {
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Prop = "Terraform"
        Name = "dev-5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
}
```

### Criando variaveis do tipo map
variable "cdirs_acesso_remoto" {
  type = list
  
  default = [
    "191.1.1.1/32", "191.1.1.2/32"
  ]
}

### Acessando variaveis do tipo map
# Create a security group
resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "acesso_ssh"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_acesso_remoto
  }

  tags = {
    Prop = "Terraform"
    Name = "ssh"
  }
}


# Create a security group another provider/region
resource "aws_security_group" "acesso_ssh-us-east-2" {
    provider = aws.us-east-2
    name        = "acesso_ssh"
    description = "acesso_ssh"

    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = var.cdirs_acesso_remoto
    }

    tags = {
        Prop = "Terraform"
        Name = "ssh"
    }
}