#!/usr/bin/env fish

# Add kubebuilder completion if it is present
if command -sq kubebuilder
    source (kubebuilder completion fish | psub)
end

