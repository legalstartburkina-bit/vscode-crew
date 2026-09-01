BeforeAll {
    $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
    $installScript = Join-Path $repoRoot 'install.ps1'
    $skillScript = Join-Path $repoRoot 'install-skill.ps1'
    $testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('vscode-crew-tests-' + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $testRoot | Out-Null
}

AfterAll {
    if (Test-Path -LiteralPath $testRoot) {
        Remove-Item -LiteralPath $testRoot -Recurse -Force
    }
}

Describe 'install.ps1' {
    It 'installs into a workspace with existing .github directories' {
        $workspace = Join-Path $testRoot 'workspace'
        New-Item -ItemType Directory -Path (Join-Path $workspace '.github/skills') -Force | Out-Null

        & $installScript -Workspace $workspace -From Local

        (Test-Path (Join-Path $workspace '.github/agents/captain.agent.md')) | Should -BeTrue
        (Test-Path (Join-Path $workspace '.github/skills/repository-analysis/SKILL.md')) | Should -BeTrue
        (Test-Path (Join-Path $workspace '.github/hooks/crew-safety.json')) | Should -BeTrue
    }
}

Describe 'install-skill.ps1' {
    It 'infers GitHub mode when SkillName is supplied' {
        $content = Get-Content -LiteralPath $skillScript -Raw
        $content | Should -Match '\$From = ''GitHub'''
    }

    It 'installs a local skill into a workspace' {
        $workspace = Join-Path $testRoot 'skill-workspace'
        New-Item -ItemType Directory -Path $workspace | Out-Null

        & $skillScript -SkillPath (Join-Path $repoRoot '.github/skills/bug-triage') -Scope Workspace -Workspace $workspace

        (Test-Path (Join-Path $workspace '.github/skills/bug-triage/SKILL.md')) | Should -BeTrue
    }
}
