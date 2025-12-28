# Summit Challenge

> Disclaimer: Everything written here contains possible spoilers in case you’re also doing the challenges. I advise to use it only if you feel stuck, as the main purpose of this write up is to show my cybersecurity skills.

## Objective
- Conduct a threat simulation and detection engineering engagement to improve malware detection capabilities.
- Work with an external penetration tester in an iterative purple-team event
- Configure security tools to detect and prevent the malware from executing as the penetration tester do their steps to execute malware on the simulated internal user workstation.
- Follow the Pyramid of Pain’s path from the base to the top.
### Summarized emails from the pentester and blocking phases
#### Email - 1
- The pentester says they’ll start our teamwork of conducting simulation and detection engineering tests.
- They will try to execute the malware on a simulated compromised account to see the efficiency of the detection tool.
- The methods will increase in difficulty as they progress.
- I’ll have to scan a file called sample1.exe to see in which way I can block it from executing.
#### Blocking Phase - 1 - Hashes
- We proceed to scan the sample1.exe finding the next information:
<img width="691" height="388" alt="1" src="https://github.com/user-attachments/assets/928b61bf-347e-4453-bc77-62f008555b74" />

- If we follow the pyramid of pain the first thing to notice is the hash of the file as it’s the first item.
- So we can determine that any of the hashes would provide what we need to block the malware from executing. (Through a hash function we get one of the codes, representing the exact file in a coded value).
- In this case we’ll take the SHA256 value:
    - 9c550591a25c6228cb7d74d970d133d75c961ffed2ef7180144859cc09efca8c
<img width="428" height="560" alt="2" src="https://github.com/user-attachments/assets/5411f27a-dd54-4c8d-8066-c64af2907d9d" />

- Once we submit the hash it will be effectively blocked, so the moment the malware is detected again through its hashed value, it’ll be automatically blocked.
<img width="830" height="91" alt="3" src="https://github.com/user-attachments/assets/539408b6-a770-4d3c-a53d-9f4159bcec8a" />

- Now we’ll go back to the emails to get the answer we need for the question and proceed to the next one.
#### Email - 2
- We receive the answer to the question 1 which is:
    - THM{f3cbf08151a11a6a331db9c6cf5f4fe4}
- The pentester congratulates us, however… There’s a big catch… The hash indeed is one of the least efficient ways to block something, as they can be easily modified just with a single change on the file, one minimal change is enough.
- So we’re now challenged with a second file called sample2.exe as the hash will be altered and it won't be blocked anymore.
#### Blocking Phase - 2 - IP
- Now it’s time to get on the next step of the pyramid, the IP address.
- I scan the next file, as hashes won’t be useful anymore at this point, we’ll try to get information related to the next phase on the pyramid.
<img width="838" height="317" alt="4" src="https://github.com/user-attachments/assets/697d06e4-f867-44a4-b284-39ee586e04fe" />

<img width="834" height="495" alt="5" src="https://github.com/user-attachments/assets/33fdd582-6923-4226-979d-5409dd4be81d" />

- Here we have a lot of important information but the most remarkable is the fact that the ip address 154.35.10.113 with port 4444, seems to be associated with a clearly suspicious domain as opposed to the other two.
- We have Intrabuzz Hosting Limited, not only that, it’s also doing kind of an odd request to that url, using also a weird port.
- So we’ll proceed to block not only the incoming connections from that IP but also the outgoing ones by creating a firewall rule. Just to be sure nothing related to it can be received nor sent.
<img width="540" height="342" alt="6" src="https://github.com/user-attachments/assets/daf4a7b1-00e6-494b-a171-1c59297baf62" />

- Here we create a rule on the firewall to block everything that comes from the suspicious ip 154.35.10.113 to any of our beloved computers using the keyword “Any”.
<img width="538" height="340" alt="7" src="https://github.com/user-attachments/assets/ff6d192c-b504-44ab-9c06-7b79256ced1f" />

- Here we create another rule in this case to block everything that goes from any of our computers to the suspicious ip. We don’t want any kind of exfiltration to happen.
- So here we go, blocked!
<img width="720" height="91" alt="8" src="https://github.com/user-attachments/assets/f34c9276-f277-4403-b93d-04e2ad13d61a" />

- Now time to get our answer for the second question and proceed on to the next pyramid level.
#### Email - 3
- We receive the answer to the question 2 which is:
    - THM{2ff48a3421a938b388418be273f4806d}
- The pentester congratulates us, but as we expected, that’s only the second level of the pyramid of pain, so it’ll also be easy to go through again.
- It tells us they’ve made it harder to know which ip we had to block through one of the ways this can be done.
- Time to scan the sample3.exe
#### Blocking Phase - 3 - DNS
- Okay so on this part, we’ll skip almost all the scanned information to get on the most relevant:
<img width="833" height="194" alt="9" src="https://github.com/user-attachments/assets/45b29d61-47b9-4792-aa84-6ca18f01bbaf" />

<img width="829" height="425" alt="10" src="https://github.com/user-attachments/assets/023018ee-4592-4e09-9f5e-ed913e2fed02" />

- The next point on the pyramid of pain is the DNS.
- It’s kind of odd to see that there are different exes getting through a domain called “emudyn.bresonicz.info” there only seems to be one legit dns here and it’s definitely not that one.
- Not only that, the Behaviour Analysis also gives us some interesting information.
- So it’s time to filter the DNS so our pentester team painfully agrees that they couldn’t deal with us again.
<img width="539" height="406" alt="11" src="https://github.com/user-attachments/assets/d0d0e847-7f26-49aa-a9cd-ad04e76fd555" />

- It’s important when blocking something to give a good name to know what we’re blocking exactly.
- We specify the domain name, select what we want to do with it and state the category so everything is organized.
- And… there we go!
<img width="720" height="92" alt="12" src="https://github.com/user-attachments/assets/448639ad-c540-40a8-a14f-51150e5dff85" />

- Let’s get the answer for question 3 and on to the next one. Just 2 left.
#### Email - 4
- We receive the answer to the question 3 which is:
    - THM{4eca9e2f61a19ecd5df34c788e7dce16}
- The pentesting team is starting to get annoyed but proud. At this time we’re getting to the last 3 phases of the pyramid of pain, Network / Host Artifacts, Tools, and TTPs.
- We’re invited to improve our blocking field by checking the artifacts of the new sample4.exe.
- They won’t yield easily on their task, neither will we!
#### Blocking Phase - 4 - Network / Host Artifacts
- So here we are, time to scan the new file:
<img width="465" height="190" alt="13" src="https://github.com/user-attachments/assets/2cd6b46e-be14-4602-b556-dbb89f3f513d" />

<img width="831" height="163" alt="14" src="https://github.com/user-attachments/assets/403a31b0-a469-47a4-b120-9c954870fb53" />

- Ok, disabling our real-time protection, that’s not good. Time to get on our Sigma Rule Builder so we can prevent this.
<img width="506" height="292" alt="15" src="https://github.com/user-attachments/assets/901184b0-50ac-4c83-9d1f-40c9c8333652" />

- We have to create a rule related to the Sysmon, as the new malware interferes with the system's register. We need to prevent that.
<img width="504" height="147" alt="16" src="https://github.com/user-attachments/assets/32c27d7d-f123-4c0b-abf9-9bdc5a7b1746" />

- We have to select Registry Modifications on step 2 as it’s the one the malware manipulates.
<img width="503" height="393" alt="17" src="https://github.com/user-attachments/assets/563ca7ec-3df4-4d36-b48a-f7fde76c0a86" />

- We just follow the requested options, the first one is entering the modified registry key.
- Next we enter the name of the registry name.
- To finish, we put in the value modified by the malware and follow the established type of nomination according to the MITRE framework. We have a multiple selection, however in this case we can rest assured it’s Defense Evasion as Disabling windows defender is a way to avoid its protection.
- So there we go, we now get the fourth answer!
#### Email - 5
- The pentester team is not only proud of us, but also annoyed. They give us the answer to question 4 which is:
    - THM{c956f455fc076aea829799c0876ee399}
- We get some formal complaints from our pentester team. With new reports and new information to clarify.
- So time to do some scans and get the log from the last 12 hours of the victim’s machine.
#### Blocking Phase - 5 - Tools
- Here are the contents of the file outgoing_connections.log:

```
2023-08-15 09:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 09:23:45 | Source: 10.10.15.12 | Destination: 43.10.65.115 | Port: 443 | Size: 21541 bytes
2023-08-15 09:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 10:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 10:14:21 | Source: 10.10.15.12 | Destination: 87.32.56.124 | Port: 80 | Size: 1204 bytes
2023-08-15 10:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 11:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 11:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 11:45:09 | Source: 10.10.15.12 | Destination: 145.78.90.33 | Port: 443 | Size: 805 bytes
2023-08-15 12:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 12:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 13:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 13:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 13:32:17 | Source: 10.10.15.12 | Destination: 72.15.61.98 | Port: 443 | Size: 26084 bytes
2023-08-15 14:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 14:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 14:55:33 | Source: 10.10.15.12 | Destination: 208.45.72.16 | Port: 443 | Size: 45091 bytes
2023-08-15 15:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 15:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 15:40:10 | Source: 10.10.15.12 | Destination: 101.55.20.79 | Port: 443 | Size: 95021 bytes
2023-08-15 16:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 16:18:55 | Source: 10.10.15.12 | Destination: 194.92.18.10 | Port: 80 | Size: 8004 bytes
2023-08-15 16:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 17:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 17:09:30 | Source: 10.10.15.12 | Destination: 77.23.66.214 | Port: 443 | Size: 9584 bytes
2023-08-15 17:27:42 | Source: 10.10.15.12 | Destination: 156.29.88.77 | Port: 443 | Size: 10293 bytes
2023-08-15 17:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 18:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 18:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 19:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 19:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 20:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 20:30:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
2023-08-15 21:00:00 | Source: 10.10.15.12 | Destination: 51.102.10.19 | Port: 443 | Size: 97 bytes
```

- And here we have the scan of sample5.exe:
<img width="836" height="256" alt="18" src="https://github.com/user-attachments/assets/ce35461e-7921-4503-9b52-12a90f81d2a8" />

- Ok, so… We can assume a huge possibility here… Our scan says that something is being downloaded from the Internet, and not only that, there are a high number of consecutive connections.
- We can also notice something incredibly remarkable… On the log, there’s a very interesting pattern that happens too frequently.
- Can you see it?
- That’s it, every half hour, something is being transferred with the same exact size, from the same ip to the same place… Is it really normal to download a thing every half hour? Don’t we all download everything at the same time?
- So that must be our clue.
- Let’s go back to sigma rule builder.
<img width="503" height="239" alt="19" src="https://github.com/user-attachments/assets/e87f7ac9-45e8-4551-9bda-7fbebc71e238" />

- We create a Sysmon Event Log
- On step 2, we select Network Connections.
- Then we create the following rule:
<img width="503" height="392" alt="20" src="https://github.com/user-attachments/assets/443acbc2-5b17-4d7b-aeb6-4432d47f0559" />

- As the attack has evolved and our attacker might have access to pointing to any ip or any port, we want to make sure both have the word any included.
- The size of the downloaded thing is exactly 97 bytes all the time, so we’ll put that.
- The frequency is exactly 30min = 1800 seconds.
- The ATT&CK ID may be a bit more confusing in this part, so we check the MITRE framework and see that the most accurate one is Command and Control.
- So we got it, the next answer and last challenge from our pentesting team!
#### Email - 6
- We get the answer to question 5, which is:
    - THM{46b21c4410e47dc5729ceadef0fc722e}
- So here we go on our last step to annoy and block definitely our pentester team efforts.
- As the pentester team well knows now, we’re on the last phase of the pyramid, TTPs, once we get to this part and block the attacker, they might need some time until they fight back because we’ll know all the techniques, tactics and procedures they’re gonna throw at us.
- So there we go to the last part of our challenge.
#### Blocking phase - 6 - TTPs - Final
- Here’s the data of the commands.log sent by our pentesting team

```
dir c:\ >> %temp%\exfiltr8.log
dir "c:\Documents and Settings" >> %temp%\exfiltr8.log
dir "c:\Program Files\" >> %temp%\exfiltr8.log
dir d:\ >> %temp%\exfiltr8.log
net localgroup administrator >> %temp%\exfiltr8.log
ver >> %temp%\exfiltr8.log
systeminfo >> %temp%\exfiltr8.log
ipconfig /all >> %temp%\exfiltr8.log
netstat -ano >> %temp%\exfiltr8.log
net start >> %temp%\exfiltr8.log
```

- And here is our scan:
<img width="689" height="372" alt="21" src="https://github.com/user-attachments/assets/a12317f9-dd5c-4436-ac37-fd34c43c8e47" />

<img width="832" height="211" alt="22" src="https://github.com/user-attachments/assets/defff034-1e31-4425-8cfe-5d163584d59f" />

<img width="833" height="242" alt="23" src="https://github.com/user-attachments/assets/564cc71f-6c84-4375-9e88-45de68cc53fd" />

<img width="832" height="129" alt="24" src="https://github.com/user-attachments/assets/34cfe752-49b8-4961-b2e0-94077af51c3f" />

<img width="503" height="220" alt="25" src="https://github.com/user-attachments/assets/faac6df9-abe0-4dd2-99c2-516db0aa0c4d" />


- In the last phase, we’ll see that we need to create a rule for file creation and modification also with the help of Sigma. Including the File Path, the File Name and MITRE ATT&CK ID set as Exfiltration as they wanted to extract information f
- The pentesting team was creating a file through the use of some cmd commands in order to extract some overall info from our system.
- We now can conclude our penetration testing team was trying to infiltrate in our system in order to exfiltrate information. As we have learned about their TTPs, now they can rest assured we know what their future paths might be if they keep operating in this way.
- Now that we have discovered their motivations and how they operate, we can be safe for some time, as they know we can block their future attempts at least until they elaborate another plan, but fortunately, it might be a while until they try again.
- We get our final answer for question 6:
    - THM{c8951b2ad24bbcbac60c16cf2c83d92c}

### Questions to answers
#### 1- What is the first flag you receive after successfully detecting sample1.exe?
Answer: THM{f3cbf08151a11a6a331db9c6cf5f4fe4}
#### 2 – What is the second flag you receive after successfully detecting sample2.exe?
Answer: THM{2ff48a3421a938b388418be273f4806d}
#### 3 – What is the third flag you receive after successfully detecting sample3.exe?
Answer: THM{4eca9e2f61a19ecd5df34c788e7dce16}
#### 4 – What is the fourth flag you receive after successfully detecting sample4.exe?
Answer: THM{c956f455fc076aea829799c0876ee399}
#### 5 – What is the fifth flag you receive after successfully detecting sample5.exe?
Answer: THM{46b21c4410e47dc5729ceadef0fc722e}
#### 6 – What is the final flag you receive from Sphinx?
Answer: THM{c8951b2ad24bbcbac60c16cf2c83d92c}

### Thoughts

- This challenge helped us acknowledge how the pyramid of pain can work in the case of an attack.
- Ascending on its path, we can conclude with different reasonings:
    - Hashes, while easy to block, are very easy to change for threat actors, which also doesn’t give us much information on how they operate.
    - IPs, they can serve some purpose while trying to be defended, however… There’s the catch that they’re easily fakeable, not only that but it doesn’t require much effort as attackers can change them or use multiple computers which could make blocking just one completely useless.
    - DNS, it’s one step forward in order to defend ourselves, although, it starts to annoy the attacker team, it’s still not enough nor highly reliable.
    - Network / Host artifacts, this is where things start getting serious for our adversaries, as they’re getting more and more power removed and discovered. It’s a big improvement but they still can make some changes.
    - Tools, this is where we start getting even more serious, at this point we’re just one step left to know what could motivate our attackers, what is the point of their attacks, what they are trying to obtain. Knowing their weapons, we can get appropriate shields to defend from them. If they try to use water to flood our ship by using a hole, we might be able to stop them closing that hole.
    - TTPs, and this one. Is the key, the last step. Here we not only know all of the above, but we finally acknowledge what their steps are:
        - What they were trying to accomplish.
        - What they wanted to do with our data.
        - Which data they wanted to steal if that was the case.
        - What tools they were using or which ones could be the next selected.
        - What could be the next reasoning…
        - There are even more questions we have asked with this last step, now we know for sure they might take some time to attack us or they might need to use another approach.
        - No matter what, we’ll try to be prepared for the next threats.
