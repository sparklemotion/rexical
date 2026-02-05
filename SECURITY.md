# Security Policy

## Supported Versions

Use this section to tell people about which versions of your project are
currently being supported with security updates.

| Version | Supported          |
| ------- | ------------------ |
| 5.1.x   | :white_check_mark: |
| 5.0.x   | :x:                |
| 4.0.x   | :white_check_mark: |
| < 4.0   | :x:                |

## Reporting a Vulnerability

Use this section to tell people how to report a vulnerability.

Tell them where to go, how often they can expect to get an update on a
reported vulnerability, what to expect if the vulnerability is accepted or
declined, etc.
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Custom License Policy Summary</title>
    <!-- Security & Performance Headers -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; style-src 'self' 'unsafe-inline'; font-src 'self';">
    <meta http-equiv="X-Content-Type-Options" content="nosniff">
    <meta http-equiv="X-Frame-Options" content="DENY">
    <meta http-equiv="X-XSS-Protection" content="1; mode=block">
    <!-- SEO & Accessibility -->
    <meta name="description" content="Customized license policy summary optimized for compliance and risk mitigation">
    <meta name="robots" content="index, follow">
    <link rel="canonical" href="YOUR-WEBSITE-URL-HERE">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Arial, sans-serif; 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 2rem 1.5rem; 
            line-height: 1.7; 
            color: #2d3748;
            background-color: #f8f9fa;
        }
        h1 { 
            color: #2b6cb0; 
            text-align: center; 
            margin-bottom: 2.5rem;
            border-bottom: 3px solid #2b6cb0;
            padding-bottom: 1rem;
        }
        h2 { 
            color: #2c5282; 
            margin-top: 2rem;
            margin-bottom: 1rem;
            padding-left: 0.5rem;
            border-left: 4px solid #2c5282;
        }
        .section { 
            background-color: white; 
            padding: 1.5rem 2rem; 
            margin-bottom: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .strength-note { 
            color: #2f855a; 
            font-weight: 600;
            font-style: italic;
            margin-bottom: 1rem;
        }
        ul { 
            margin-left: 1.8rem; 
            margin-bottom: 1rem;
        }
        li { margin-bottom: 0.5rem; }
        .mitigation-note { 
            color: #718096; 
            font-size: 0.95rem;
            margin-top: 0.5rem;
            padding-top: 0.5rem;
            border-top: 1px solid #e2e8f0;
        }
        .enhancements {
            background-color: #edf2f7;
            padding: 2rem;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <h1>CUSTOM LICENSE POLICY SUMMARY</h1>
    <p style="text-align: center; font-size: 1.1rem; margin-bottom: 2.5rem;"><em>Optimized for Clarity, Compliance & Risk Mitigation</em></p>

    <div class="section">
        <h2>1. APPROVED LICENSES FRAMEWORK</h2>
        <p class="strength-note">Strength: Curated list of low-risk, widely-accepted licenses to ensure legal certainty and operational flexibility</p>
        
        <ul>
            <li><strong>Core Permissive Licenses</strong> (industry-standard, minimal restrictions):
                <ul>
                    <li>BSD family (0BSD, 1-Clause, 2-Clause [all variants], 3-Clause [all variants], 4-Clause [legacy allowed where required])</li>
                    <li>MIT family (MIT, MIT-0, MIT-Modern-Variant, and other vetted variants)</li>
                    <li>Apache Licenses (1.0, 1.1, 2.0)</li>
                    <li>ISC, Zlib, BSL-1.0, BlueOak-1.0.0, Unlicense</li>
                </ul>
            </li>
            <li><strong>Creative Works Licenses</strong> (clear usage rights, no commercial restrictions):
                <ul>
                    <li>CC-BY (all versions, including regional variants)</li>
                    <li>CC0-1.0 (public domain dedication)</li>
                    <li>CC-PDDC (public domain for data)</li>
                </ul>
            </li>
            <li><strong>Specialized Approved Licenses</strong> (vetted for safety and compatibility):
                <ul>
                    <li>Artistic 1.0/2.0, MulanPSL 1.0/2.0, Beerware, WTFPL</li>
                    <li>Project-specific licenses (e.g., Libpng, Json, Intel, PostgreSQL)</li>
                    <li>General categories: Public domain content, contributor license agreements (CLAs), and all "permissive" model/subcategory licenses</li>
                </ul>
            </li>
        </ul>
        
        <p class="mitigation-note">Vulnerability Mitigation: Removed ambiguous or legacy license references that could cause interpretation conflicts; all listed licenses have clear, publicly-audited terms</p>
    </div>

    <div class="section">
        <h2>2. WARNING & MONITORING CATEGORIES</h2>
        <p class="strength-note">Strength: No gray areas – policies are binary (approved/denied) to eliminate decision delays or errors</p>
        
        <ul>
            <li><strong>Warn Category</strong>: Empty
                <ul><li>Rationale: No licenses are placed here to avoid confusion about acceptable use; all licenses are either clearly allowed or denied</li></ul>
            </li>
            <li><strong>Monitor Category</strong>: Empty
                <ul><li>Rationale: Monitoring is handled proactively through pre-approval of all allowed licenses, rather than reactive tracking of potentially risky ones</li></ul>
            </li>
        </ul>
        
        <p class="mitigation-note">Vulnerability Mitigation: Eliminated the risk of unapproved licenses being used while "under monitoring"; ensures consistent enforcement</p>
    </div>

    <div class="section">
        <h2>3. DENIED LICENSES FRAMEWORK</h2>
        <p class="strength-note">Strength: Comprehensive block of high-risk licenses to protect intellectual property, avoid compliance burdens, and prevent legal exposure</p>
        
        <ul>
            <li><strong>Prohibited License Types</strong>:
                <ul>
                    <li><strong>Copyleft Licenses</strong> (risk of forced code disclosure): AGPL, GPL (all versions/exceptions), LGPL, GFDL, MPL, CDDL, EPL, EUPL</li>
                    <li><strong>Restricted Creative Commons Licenses</strong> (limit commercial use or modification): CC-BY-NC, CC-BY-NC-ND, CC-BY-NC-SA, CC-BY-ND (all versions)</li>
                    <li><strong>AI/ML-Specific Restricted Licenses</strong> (ambiguous or restrictive terms): OpenRAIL variants, Llama series licenses, CreativeML-Open-Rail-M</li>
                    <li><strong>High-Risk Commercial/Restrictive Licenses</strong>: BUSL-1.1, SSPL-1.0, PolyForm non-commercial/restrictive variants, most Microsoft-specific licenses</li>
                    <li><strong>Legacy/Ambiguous Licenses</strong>: APSL, OSL, QPL, RPL, and unvetted project-specific licenses</li>
                </ul>
            </li>
        </ul>
        
        <p class="mitigation-note">Vulnerability Mitigation: Removed any denied licenses that could be misinterpreted as partially allowed; explicitly blocks licenses with patent risks, viral terms, or unclear enforcement rules</p>
    </div>

    <div class="section">
        <h2>4. POLICY OPTIONS</h2>
        <p class="strength-note">Strength: Clear operational rules to ensure consistent application</p>
        
        <ul>
            <li><strong>toplevelOnly</strong>: Ensures license checks apply only to top-level components, preventing accidental denial due to nested dependencies with approved licenses</li>
            <li><strong>applyToUnidentified</strong>: Automatically treats any unrecognized license as denied, eliminating the risk of unvetted licenses being used</li>
        </ul>
        
        <p class="mitigation-note">Vulnerability Mitigation: Prevents "loophole" usage of unlisted or mislabeled licenses; ensures consistent application across all components</p>
    </div>

    <div class="section enhancements">
        <h2>ENHANCEMENTS MADE FOR YOUR ADVANTAGE</h2>
        <ol>
            <li><strong>Risk Reduction</strong>: Removed all ambiguous language and structured categories to eliminate enforcement gaps</li>
            <li><strong>Clarity</strong>: Framed each section to highlight benefits to your organization (e.g., "protects intellectual property")</li>
            <li><strong>Compliance</strong>: Ensured denied licenses align with common corporate governance requirements</li>
            <li><strong>Usability</strong>: Organized licenses by type to make it easy for teams to find and verify acceptable options</li>
            <li><strong>Future-Proofing</strong>: Structured the policy so new licenses can be added to approved/denied lists without disrupting existing rules</li>
        </ol>
    </div>

</body>
</html>
