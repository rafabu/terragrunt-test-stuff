# terragrunt v0.99.4 and v1.0.0-rc2 changes behaviour of get_original_terragrunt_dir() when running in (implicit) stack

## Describe the bug

terragrunt configuration involving `get_original_terragrunt_dir()` changed the behavior in `v0.99.4` and ` v1.0.0-rc2`. It works still returns an individual unit's path, when running in a single folder (unit). However, running an entire (implicit) stack with `run --all` on a folder structure of units, the path returned now is the unit folder from where the stack was called.

With previous version up to and including `v0.99.3`, `get_original_terragrunt_dir()` always retuned the path to each unit's path (where terragrunt.hcl file resides.

Is this an intended change and if so, what alternative exists reliably detect the folder if the unit in an implicit stack?

## Reproducing bugs

Repository with sample unit configuration can be found here:
 
Command to verify:
`terragrunt render --all --working-dir ./deployments/tests/terragrunt_v0.99.4/`
`terragrunt_v0.99.4 run plan --all --working-dir ./deployments/tests/terragrunt_v0.99.4/`
  --> works with terragrunt <= v0.93.3
  --> error 


The exceptions to requiring steps to reproduce are:

1. You are reporting a bug that you don't know how to reproduce, but you are reporting it so that others in the community are aware of it.
2. You are willing to fix the bug yourself, and you accept the responsibility of ensuring that the bug is valid, and that the fix is well tested.

How to provide steps for reproduction:

The most common way to provide steps for reproduction is to create a minimal example that reproduces the bug, and steps to run that example to reproduce the issue. Maintainers will refer to this example as a "fixture" when asking questions about reproduction.

You can either do so with code snippets in this issue, or by creating a public Git repository that contains the minimal example, with instructions for running the example.

You can delete this section right before submitting the issue, if you like.

## Steps To Reproduce

Steps to reproduce the behavior, code snippets and examples which can be used to reproduce the issue.

Be sure that the maintainers can actually reproduce the issue. Bug reports that are too vague or hard to reproduce are hard to troubleshoot and fix.

```hcl
// paste code snippets here
```

## Expected behavior

A clear and concise description of what you expected to happen.

## Must haves

- [ ] Steps for reproduction provided.

## Nice to haves

- [ ] Terminal output
- [ ] Screenshots

## Versions

- Terragrunt version:
- OpenTofu/Terraform version:
- Environment details (Ubuntu 20.04, Windows 10, etc.):

## Additional context

Add any other context about the problem here.
