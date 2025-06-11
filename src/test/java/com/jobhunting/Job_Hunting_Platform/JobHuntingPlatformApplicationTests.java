package com.jobhunting.Job_Hunting_Platform;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;

@Import(TestcontainersConfiguration.class)
@SpringBootTest
class JobHuntingPlatformApplicationTests {

	@Test
	void contextLoads() {
	}

}
