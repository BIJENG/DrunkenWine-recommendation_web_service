package com.example.myboard.service;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

// msg id    : msg_4yalmn3wg5cLew6jUesUiAUA
// run id    : run_6R6GwsxPd72YNjGv8uYPuN7x
// thread id : thread_INcAWMHoSeBjtCYYapYh3WC2
// msg2 id   : msg_ZTszHcWRNhBL8UIc6sABRIEI
// assist id : asst_XxTjz8aUtixXgN8OHSGr4qqg
// run2 id   : run_96SgRWtlv4xgJhPPIqfrKAV9

@Service
public class ChatGPTApiClient {

    @Autowired
    private RestTemplate restTemplate;
    public String threadId;
    public String msgId;
    public String runsId;
    public boolean isRunOk;
    public String botResponse;
    public boolean firstMsgCheck = true;
    public String getGPTwine;

    @Value("${api.key}")
    private String apiKey;

    public String chatbot(String prompt) {

        if (firstMsgCheck == true) {
            threadId = createThread();
        }

        msgId = createMsg(prompt, threadId);
        runsId = createRun(threadId);
        isRunOk = checkRun(threadId, runsId);
        botResponse = getList(threadId);

        return botResponse;
    }

    public String wineTag(String prompt) {
        threadId = createThread();
        msgId = createTagMsg(prompt, threadId);
        runsId = createOnlyNumRun(threadId);
        isRunOk = checkRun(threadId, runsId);
        botResponse = getList(threadId);

        JSONObject jsonObject = new JSONObject(botResponse);

        getGPTwine = jsonObject
                .getJSONArray("data")
                .getJSONObject(0) // 첫 번째 객체를 가져옴
                .getJSONArray("content")
                .getJSONObject(0) // 첫 번째 content 객체를 가져옴
                .getJSONObject("text")
                .getString("value");

        return filterGetGPTwine(getGPTwine);
    }

    public String createThread() {
        String threadId;

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Authorization", "Bearer " + apiKey);
        headers.add("OpenAI-Beta", "assistants=v2");
        String requestBody = "";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange("https://api.openai.com/v1/threads", HttpMethod.POST,
                entity, String.class);
        JSONObject jsonObject = new JSONObject(response.getBody());
        System.out.println(jsonObject.getString("id"));
        threadId = jsonObject.getString("id");
        firstMsgCheck = false;
        return threadId;

    }

    public String createMsg(String prompt, String threadId) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Authorization", "Bearer " + apiKey);
        headers.add("OpenAI-Beta", "assistants=v2");
        String requestBody = "{\"role\": \"user\", \"content\": \" " + prompt + "\"}";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(
                "https://api.openai.com/v1/threads/" + threadId + "/messages", HttpMethod.POST, entity, String.class);
        JSONObject jsonObject = new JSONObject(response.getBody());
        System.out.println(jsonObject.getString("id"));
        return jsonObject.getString("id");
    }

    public String createTagMsg(String prompt, String threadId) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Authorization", "Bearer " + apiKey);

        headers.add("OpenAI-Beta", "assistants=v2");
        String requestBody = "{\"role\": \"user\", \"content\": \" " + prompt + "와인 8개만 추천해줘\"}";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(
                "https://api.openai.com/v1/threads/" + threadId + "/messages", HttpMethod.POST, entity, String.class);
        JSONObject jsonObject = new JSONObject(response.getBody());
        System.out.println(jsonObject.getString("id"));
        return jsonObject.getString("id");
    }

    public String createRun(String threadId) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Authorization", "Bearer " + apiKey);

        headers.add("OpenAI-Beta", "assistants=v2");
        String requestBody = "{\"assistant_id\": \"asst_XxTjz8aUtixXgN8OHSGr4qqg\"}";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(
                "https://api.openai.com/v1/threads/" + threadId + "/runs", HttpMethod.POST, entity, String.class);
        JSONObject jsonObject = new JSONObject(response.getBody());
        System.out.println(jsonObject.getString("id"));
        return jsonObject.getString("id");
    }

    public String createOnlyNumRun(String threadId) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Authorization", "Bearer " + apiKey);

        headers.add("OpenAI-Beta", "assistants=v2");
        String requestBody = "{\"assistant_id\": \"asst_S1KMfXA7IDuGoAEaOMGH03vU\"}";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(
                "https://api.openai.com/v1/threads/" + threadId + "/runs", HttpMethod.POST, entity, String.class);
        JSONObject jsonObject = new JSONObject(response.getBody());
        System.out.println(jsonObject.getString("id"));
        return jsonObject.getString("id");
    }

    public boolean checkRun(String threadId, String runsId) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Authorization", "Bearer " + apiKey);

        headers.add("OpenAI-Beta", "assistants=v2");
        String requestBody = "";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        try {
            while (true) {
                ResponseEntity<String> response = restTemplate.exchange(
                        "https://api.openai.com/v1/threads/" + threadId + "/runs/" + runsId, HttpMethod.GET, entity,
                        String.class);
                JSONObject jsonObject = new JSONObject(response.getBody());
                String status = jsonObject.getString("status");

                if ("completed".equals(status)) {
                    System.out.println("완료 됐습니다.");
                    break;
                }

                System.out.println("완료가 안됐습니다.");
                Thread.sleep(2000); // 2초 대기
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt(); // 현재 쓰레드의 interrupt 상태를 설정
            System.err.println("Thread was interrupted");
        } catch (JSONException e) {
            System.err.println("JSON 처리 중 오류 발생: " + e.getMessage());
        } catch (RestClientException e) {
            System.err.println("API 호출 중 오류 발생: " + e.getMessage());
        }

        return true;
    }

    public String getList(String threadId) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Authorization", "Bearer " + apiKey);

        headers.add("OpenAI-Beta", "assistants=v2");
        String requestBody = "";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(
                "https://api.openai.com/v1/threads/" + threadId + "/messages", HttpMethod.GET, entity, String.class);

        return response.getBody();
    }
    // ------------------ 이상한 글씨 안나오게 에러방지용---------------------------//

    public static String filterGetGPTwine(String input) {
        // 첫 번째 숫자의 위치를 찾습니다.
        int startIndex = -1;
        for (int i = 0; i < input.length(); i++) {
            if (Character.isDigit(input.charAt(i))) {
                startIndex = i;
                break;
            }
        }

        // 숫자가 없으면 빈 문자열을 반환합니다.
        if (startIndex == -1) {
            return "";
        }

        // 숫자, 쉼표, 공백으로 이루어진 부분을 추출합니다.
        StringBuilder result = new StringBuilder();
        boolean inNumberSequence = true;
        for (int i = startIndex; i < input.length(); i++) {
            char currentChar = input.charAt(i);
            if (Character.isDigit(currentChar) || currentChar == ',' || currentChar == ' ') {
                if (inNumberSequence) {
                    result.append(currentChar);
                }
            } else {
                // 숫자, 쉼표, 공백이 아닌 문자를 만나면 종료합니다.
                inNumberSequence = false;
                break;
            }
        }

        return result.toString().trim();
    }

}
