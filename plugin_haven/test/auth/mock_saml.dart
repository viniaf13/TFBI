class MockAuthResponse {
  // Example token from oauth.com
  final Map<String, dynamic> token = {
    "access_token": "ya29.Glins-oLtuljNVfthQU2bpJVJPTu",
    "token_type": "Bearer",
    "expires_in": 3600,
    "id_token":
        "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFmZmM2MjkwN2E0NDYxODJhZGMxZmE0ZTgxZmRiYTYzMTBkY2U2M2YifQ.eyJhenAiOiIyNzIxOTYwNjkxNzMtZm81ZWI0MXQzbmR1cTZ1ZXRkc2pkdWdzZXV0ZnBtc3QuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIyNzIxOTYwNjkxNzMtZm81ZWI0MXQzbmR1cTZ1ZXRkc2pkdWdzZXV0ZnBtc3QuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTc4NDc5MTI4NzU5MTM5MDU0OTMiLCJlbWFpbCI6ImFhcm9uLnBhcmVja2lAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJpRVljNDBUR0luUkhoVEJidWRncEpRIiwiZXhwIjoxNTI0NTk5MDU2LCJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJpYXQiOjE1MjQ1OTU0NTZ9.ho2czp_1JWsglJ9jN8gCgWfxDi2gY4X5-QcT56RUGkgh5BJaaWdlrRhhN_eNuJyN3HRPhvVA_KJVy1tMltTVd2OQ6VkxgBNfBsThG_zLPZriw7a1lANblarwxLZID4fXDYG-O8U-gw4xb-NIsOzx6xsxRBdfKKniavuEg56Sd3eKYyqrMA0DWnIagqLiKE6kpZkaGImIpLcIxJPF0-yeJTMt_p1NoJF7uguHHLYr6752hqppnBpMjFL2YMDVeg3jl1y5DeSKNPh6cZ8H2p4Xb2UIrJguGbQHVIJvtm_AspRjrmaTUQKrzXDRCfDROSUU-h7XKIWRrEd2-W9UkV5oCg"
  };
  // Example response from salesforce.com
  final String assertion =
      'SAMLResponse=ICA8c2FtbHA6UmVzcG9uc2UgSUQ9Il8yNTdmOWQ5ZTlmYTE0OTYyYzA4MDM5MDNhNmNjYWQ5MzEyNDUyNjQzMTA3MzgiIAogICBJc3N1ZUluc3RhbnQ9IjIwMDktMDYtMTdUMTg6NDU6MTAuNzM4WiIgVmVyc2lvbj0iMi4wIj4KPHNhbWw6SXNzdWVyIEZvcm1hdD0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOm5hbWVpZC1mb3JtYXQ6ZW50aXR5Ij4KICAgaHR0cHM6Ly93d3cuc2FsZXNmb3JjZS5jb20KPC9zYW1sOklzc3Vlcj4KCjxzYW1scDpTdGF0dXM-CiAgIDxzYW1scDpTdGF0dXNDb2RlIFZhbHVlPSJ1cm46b2FzaXM6bmFtZXM6dGM6U0FNTDoyLjA6c3RhdHVzOlN1Y2Nlc3MiLz4KPC9zYW1scDpTdGF0dXM-Cgo8c2FtbDpBc3NlcnRpb24gSUQ9Il8zYzM5YmMwZmU3YjEzNzY5Y2FiMmY2ZjQ1ZWJhODAxYjEyNDUyNjQzMTA3MzgiIAogICBJc3N1ZUluc3RhbnQ9IjIwMDktMDYtMTdUMTg6NDU6MTAuNzM4WiIgVmVyc2lvbj0iMi4wIj4KICAgPHNhbWw6SXNzdWVyIEZvcm1hdD0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOm5hbWVpZC1mb3JtYXQ6ZW50aXR5Ij4KICAgICAgaHR0cHM6Ly93d3cuc2FsZXNmb3JjZS5jb20KICAgPC9zYW1sOklzc3Vlcj4KCiAgIDxzYW1sOlNpZ25hdHVyZT4KICAgICAgPHNhbWw6U2lnbmVkSW5mbz4KICAgICAgICAgPHNhbWw6Q2Fub25pY2FsaXphdGlvbk1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuIyIvPgogICAgICAgICA8c2FtbDpTaWduYXR1cmVNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjcnNhLXNoYTEiLz4KICAgICAgICAgPHNhbWw6UmVmZXJlbmNlIFVSST0iI18zYzM5YmMwZmU3YjEzNzY5Y2FiMmY2ZjQ1ZWJhODAxYjEyNDUyNjQzMTA3MzgiPgogICAgICAgICAgICA8c2FtbDpUcmFuc2Zvcm1zPgogICAgICAgICAgICAgICA8c2FtbDpUcmFuc2Zvcm0gQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjZW52ZWxvcGVkLXNpZ25hdHVyZSIvPgogICAgICAgICAgICAgICA8c2FtbDpUcmFuc2Zvcm0gQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzEwL3htbC1leGMtYzE0biMiPgogICAgICAgICAgICAgICAgICA8ZWM6SW5jbHVzaXZlTmFtZXNwYWNlcyBQcmVmaXhMaXN0PSJkcyBzYW1sIHhzIi8-CiAgICAgICAgICAgICAgIDwvc2FtbDpUcmFuc2Zvcm0-CiAgICAgICAgICAgIDwvc2FtbDpUcmFuc2Zvcm1zPgogICAgICAgICAgICA8c2FtbDpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPgogICAgICAgICAgICA8c2FtbDpEaWdlc3RWYWx1ZT52elI5SGZwOGQxNjU3NnRFRGVxL3pocG1Mb289CiAgICAgICAgICAgIDwvc2FtbDpEaWdlc3RWYWx1ZT4KICAgICAgICAgPC9zYW1sOlJlZmVyZW5jZT4KICAgICAgPC9zYW1sOlNpZ25lZEluZm8-CiAgICAgIDxzYW1sOlNpZ25hdHVyZVZhbHVlPgogICAgICAgICBBeklENWhoSmVKbEcybGxVRHZac3dOVXJsclB0UjdTMzdRWUgyVytVbjFuOGM2a1RDCiAgICAgICAgIFhyL2xpaEVLUGNBMlBadDg2ZUJudEZCVkRXVFJsaC9XM3lVZ0dPcVFCSk1GT1ZiaEsKICAgICAgICAgTS9DYkxIYkJVVlQ1VGN4SXF2c052SUZkaklHTmtmMVcwU0JxUktaT0o2dHp4Q2NMbwogICAgICAgICA5ZFhxQXlBVWtxRHBYNStBeWx0d3JkQ1BObW5jVU00ZHRSUGpJMDVDTDFyUmFHZXlYCiAgICAgICAgIDNra3FPTDhwMHZqbTBmYXpVNXRDQUpMYll1WWdVMUxpdlBTYWhXTmNwdlJTbENJNGUKICAgICAgICAgUG4yb2lWRHlyY2M0ZXQxMmluUE1UYzJsR0lXV1dXSnlIT1BTaVhSU2tFQUl3UVZqZgogICAgICAgICBRbTVjcGxpNDRQdjhGQ3JkR1dwRUUweVhzUEJ2RGtNOWpJendDWUdHMmZLYUxCYWc9PQogICAgICA8L3NhbWw6U2lnbmF0dXJlVmFsdWU-CiAgICAgIDxzYW1sOktleUluZm8-CiAgICAgICAgIDxzYW1sOlg1MDlEYXRhPgogICAgICAgICAgICA8c2FtbDpYNTA5Q2VydGlmaWNhdGU-CiAgICAgICAgICAgICAgIE1JSUVBVENDQXVtZ0F3SUJBZ0lCQlRBTkJna3Foa2lHOXcwQkFRMEZBRENCZ3pFTE0KICAgICAgICAgICAgICAgW0NlcnRpZmljYXRlIHRydW5jYXRlZCBmb3IgcmVhZGFiaWxpdHkuLi5dCiAgICAgICAgICAgIDwvc2FtbDpYNTA5Q2VydGlmaWNhdGU-CiAgICAgICAgIDwvc2FtbDpYNTA5RGF0YT4KICAgICAgPC9zYW1sOktleUluZm8-CiAgIDwvc2FtbDpTaWduYXR1cmU-CgogICA8c2FtbDpTdWJqZWN0PgogICAgICA8c2FtbDpOYW1lSUQgRm9ybWF0PSJ1cm46b2FzaXM6bmFtZXM6dGM6U0FNTDoxLjE6bmFtZWlkLWZvcm1hdDp1bnNwZWNpZmllZCI-CiAgICAgICAgIHNhbWwwMUBzYWxlc2ZvcmNlLmNvbQogICAgICA8L3NhbWw6TmFtZUlEPgoKICAgICAgPHNhbWw6U3ViamVjdENvbmZpcm1hdGlvbiBNZXRob2Q9InVybjpvYXNpczpuYW1lczp0YzpTQU1MOjIuMDpjbTpiZWFyZXIiPgogICAgICA8c2FtbDpTdWJqZWN0Q29uZmlybWF0aW9uRGF0YSBOb3RPbk9yQWZ0ZXI9IjIwMDktMDYtMTdUMTg6NTA6MTAuNzM4WiIgCiAgICAgICAgIFJlY2lwaWVudD0iaHR0cHM6Ly9sb2dpbi5zYWxlc2ZvcmNlLmNvbSIvPgogICAgICA8L3NhbWw6U3ViamVjdENvbmZpcm1hdGlvbj4KICAgPC9zYW1sOlN1YmplY3Q-CgogICA8c2FtbDpDb25kaXRpb25zIE5vdEJlZm9yZT0iMjAwOS0wNi0xN1QxODo0NToxMC43MzhaIiAKICAgICAgTm90T25PckFmdGVyPSIyMDA5LTA2LTE3VDE4OjUwOjEwLjczOFoiPgoKICAgICAgPHNhbWw6QXVkaWVuY2VSZXN0cmljdGlvbj4KICAgICAgICAgPHNhbWw6QXVkaWVuY2U-aHR0cHM6Ly9zYW1sLnNhbGVzZm9yY2UuY29tPC9zYW1sOkF1ZGllbmNlPgogICAgICA8L3NhbWw6QXVkaWVuY2VSZXN0cmljdGlvbj4KICAgPC9zYW1sOkNvbmRpdGlvbnM-CgogICA8c2FtbDpBdXRoblN0YXRlbWVudCBBdXRobkluc3RhbnQ9IjIwMDktMDYtMTdUMTg6NDU6MTAuNzM4WiI-CiAgICAgIDxzYW1sOkF1dGhuQ29udGV4dD4KICAgICAgICAgPHNhbWw6QXV0aG5Db250ZXh0Q2xhc3NSZWY-dXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmFjOmNsYXNzZXM6dW5zcGVjaWZpZWQKICAgICAgICAgPC9zYW1sOkF1dGhuQ29udGV4dENsYXNzUmVmPgogICAgICA8L3NhbWw6QXV0aG5Db250ZXh0PgogICA8L3NhbWw6QXV0aG5TdGF0ZW1lbnQ-CgogICA8c2FtbDpBdHRyaWJ1dGVTdGF0ZW1lbnQ-CgogICAgICA8c2FtbDpBdHRyaWJ1dGUgTmFtZT0icG9ydGFsX2lkIj4KICAgICAgICAgPHNhbWw6QXR0cmlidXRlVmFsdWUgeHNpOnR5cGU9InhzOmFueVR5cGUiPjA2MEQwMDAwMDAwMFNIWgogICAgICAgICA8L3NhbWw6QXR0cmlidXRlVmFsdWU-CiAgICAgIDwvc2FtbDpBdHRyaWJ1dGU-CgogICAgICA8c2FtbDpBdHRyaWJ1dGUgTmFtZT0ib3JnYW5pemF0aW9uX2lkIj4KICAgICAgICAgPHNhbWw6QXR0cmlidXRlVmFsdWUgeHNpOnR5cGU9InhzOmFueVR5cGUiPjAwREQwMDAwMDAwRjdMNQogICAgICAgICA8L3NhbWw6QXR0cmlidXRlVmFsdWU-CiAgICAgIDwvc2FtbDpBdHRyaWJ1dGU-CgogICAgICA8c2FtbDpBdHRyaWJ1dGUgTmFtZT0ic3Nvc3RhcnRwYWdlIiAKICAgICAgICAgTmFtZUZvcm1hdD0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmF0dHJuYW1lLWZvcm1hdDp1bnNwZWNpZmllZCI-CgogICAgICAgICA8c2FtbDpBdHRyaWJ1dGVWYWx1ZSB4c2k6dHlwZT0ieHM6YW55VHlwZSI-CiAgICAgICAgICAgIGh0dHA6Ly93d3cuc2FsZXNmb3JjZS5jb20vc2VjdXJpdHkvc2FtbC9zYW1sMjAtZ2VuLmpzcAogICAgICAgICA8L3NhbWw6QXR0cmlidXRlVmFsdWU-CiAgICAgIDwvc2FtbDpBdHRyaWJ1dGU-CgogICAgICA8c2FtbDpBdHRyaWJ1dGUgTmFtZT0ibG9nb3V0dXJsIiAKICAgICAgICAgTmFtZUZvcm1hdD0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmF0dHJuYW1lLWZvcm1hdDp1cmkiPgoKICAgICAgICAgPHNhbWw6QXR0cmlidXRlVmFsdWUgeHNpOnR5cGU9InhzOnN0cmluZyI-CiAgICAgICAgICAgIGh0dHA6Ly93d3cuc2FsZXNmb3JjZS5jb20vc2VjdXJpdHkvZGVsX2F1dGgvU3NvTG9nb3V0UGFnZS5odG1sCiAgICAgICAgIDwvc2FtbDpBdHRyaWJ1dGVWYWx1ZT4KICAgICAgPC9zYW1sOkF0dHJpYnV0ZT4KICAgPC9zYW1sOkF0dHJpYnV0ZVN0YXRlbWVudD4KPC9zYW1sOkFzc2VydGlvbj4KPC9zYW1scDpSZXNwb25zZT4KICA=';
  final String data = '''
  <samlp:Response ID="_257f9d9e9fa14962c0803903a6ccad931245264310738" 
   IssueInstant="2009-06-17T18:45:10.738Z" Version="2.0">
<saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">
   https://www.salesforce.com
</saml:Issuer>

<samlp:Status>
   <samlp:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success"/>
</samlp:Status>

<saml:Assertion ID="_3c39bc0fe7b13769cab2f6f45eba801b1245264310738" 
   IssueInstant="2009-06-17T18:45:10.738Z" Version="2.0">
   <saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">
      https://www.salesforce.com
   </saml:Issuer>

   <saml:Signature>
      <saml:SignedInfo>
         <saml:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
         <saml:SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
         <saml:Reference URI="#_3c39bc0fe7b13769cab2f6f45eba801b1245264310738">
            <saml:Transforms>
               <saml:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
               <saml:Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#">
                  <ec:InclusiveNamespaces PrefixList="ds saml xs"/>
               </saml:Transform>
            </saml:Transforms>
            <saml:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
            <saml:DigestValue>vzR9Hfp8d16576tEDeq/zhpmLoo=
            </saml:DigestValue>
         </saml:Reference>
      </saml:SignedInfo>
      <saml:SignatureValue>
         AzID5hhJeJlG2llUDvZswNUrlrPtR7S37QYH2W+Un1n8c6kTC
         Xr/lihEKPcA2PZt86eBntFBVDWTRlh/W3yUgGOqQBJMFOVbhK
         M/CbLHbBUVT5TcxIqvsNvIFdjIGNkf1W0SBqRKZOJ6tzxCcLo
         9dXqAyAUkqDpX5+AyltwrdCPNmncUM4dtRPjI05CL1rRaGeyX
         3kkqOL8p0vjm0fazU5tCAJLbYuYgU1LivPSahWNcpvRSlCI4e
         Pn2oiVDyrcc4et12inPMTc2lGIWWWWJyHOPSiXRSkEAIwQVjf
         Qm5cpli44Pv8FCrdGWpEE0yXsPBvDkM9jIzwCYGG2fKaLBag==
      </saml:SignatureValue>
      <saml:KeyInfo>
         <saml:X509Data>
            <saml:X509Certificate>
               MIIEATCCAumgAwIBAgIBBTANBgkqhkiG9w0BAQ0FADCBgzELM
               [Certificate truncated for readability...]
            </saml:X509Certificate>
         </saml:X509Data>
      </saml:KeyInfo>
   </saml:Signature>

   <saml:Subject>
      <saml:NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">
         saml01@salesforce.com
      </saml:NameID>

      <saml:SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:bearer">
      <saml:SubjectConfirmationData NotOnOrAfter="2009-06-17T18:50:10.738Z" 
         Recipient="https://login.salesforce.com"/>
      </saml:SubjectConfirmation>
   </saml:Subject>

   <saml:Conditions NotBefore="2009-06-17T18:45:10.738Z" 
      NotOnOrAfter="2009-06-17T18:50:10.738Z">

      <saml:AudienceRestriction>
         <saml:Audience>https://saml.salesforce.com</saml:Audience>
      </saml:AudienceRestriction>
   </saml:Conditions>

   <saml:AuthnStatement AuthnInstant="2009-06-17T18:45:10.738Z">
      <saml:AuthnContext>
         <saml:AuthnContextClassRef>urn:oasis:names:tc:SAML:2.0:ac:classes:unspecified
         </saml:AuthnContextClassRef>
      </saml:AuthnContext>
   </saml:AuthnStatement>

   <saml:AttributeStatement>

      <saml:Attribute Name="portal_id">
         <saml:AttributeValue xsi:type="xs:anyType">060D00000000SHZ
         </saml:AttributeValue>
      </saml:Attribute>

      <saml:Attribute Name="organization_id">
         <saml:AttributeValue xsi:type="xs:anyType">00DD0000000F7L5
         </saml:AttributeValue>
      </saml:Attribute>

      <saml:Attribute Name="ssostartpage" 
         NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified">

         <saml:AttributeValue xsi:type="xs:anyType">
            http://www.salesforce.com/security/saml/saml20-gen.jsp
         </saml:AttributeValue>
      </saml:Attribute>

      <saml:Attribute Name="logouturl" 
         NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri">

         <saml:AttributeValue xsi:type="xs:string">
            http://www.salesforce.com/security/del_auth/SsoLogoutPage.html
         </saml:AttributeValue>
      </saml:Attribute>
   </saml:AttributeStatement>
</saml:Assertion>
</samlp:Response>
  ''';
}
