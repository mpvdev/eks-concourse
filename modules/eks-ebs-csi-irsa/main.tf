data "tls_certificate" "oidc" {
  url = var.oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "this" {
  url = var.oidc_issuer_url

  client_id_list = [
    var.oidc_audience
  ]

  thumbprint_list = [
    data.tls_certificate.oidc.certificates[0].sha1_fingerprint
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-eks-oidc-provider"
    }
  )
}

locals {
  oidc_provider_url_without_scheme = replace(var.oidc_issuer_url, "https://", "")

  service_account_subject = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
}

data "aws_iam_policy_document" "ebs_csi_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.this.arn
      ]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url_without_scheme}:aud"
      values   = [var.oidc_audience]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url_without_scheme}:sub"
      values   = [local.service_account_subject]
    }
  }
}

resource "aws_iam_role" "ebs_csi" {
  name = "${var.name_prefix}-ebs-csi-irsa-role"

  assume_role_policy = data.aws_iam_policy_document.ebs_csi_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-ebs-csi-irsa-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy" {
  role       = aws_iam_role.ebs_csi.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}