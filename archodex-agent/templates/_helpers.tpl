{{/*
Expand the name of the chart.
*/}}
{{- define "archodex-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "archodex-agent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "archodex-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "archodex-agent.labels" -}}
helm.sh/chart: {{ include "archodex-agent.chart" . }}
{{ include "archodex-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "archodex-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "archodex-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "archodex-agent.serviceAccountName" -}}
{{- default (include "archodex-agent.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "archodex-agent.clusterRoleName" -}}
{{- default (include "archodex-agent.fullname" .) .Values.clusterRole.name }}
{{- end }}

{{/*
Create the name of the cluster role binding to use
*/}}
{{- define "archodex-agent.clusterRoleBindingName" -}}
{{- default (include "archodex-agent.fullname" .) .Values.clusterRoleBinding.name }}
{{- end }}
