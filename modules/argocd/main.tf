resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace

    labels = {
      "app.kubernetes.io/name"       = var.namespace
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.this.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  timeout = 600

  values = [
    yamlencode({
      global = {
        domain = "argocd.local"
      }

      server = {
        service = {
          type = "ClusterIP"
        }
      }

      configs = {
        params = {
          "server.insecure" = true
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.this
  ]
}