resource "aws_glue_connection" "glue_connection_{{inputs.connection_name}}"{

  catalog_id      = data.aws_caller_identity.current.account_id
  connection_type = "{%if inputs.connection_type == 'S3'%}NETWORK{%else%}JDBC{% endif %}"
  description     = "{{inputs.connection_description}}"
  name            = "{{inputs.connection_name}}"

  physical_connection_requirements {
    availability_zone      = aws_subnet.{{inputs.connection_name}}.availability_zone
    security_group_id_list = [aws_security_group.glue_security_group.id]
    subnet_id              = aws_subnet.{{inputs.connection_name}}.id
  }
}